#include "image_driver.h"

#define TASK_QUEUE_LENGTH_IMAGE 11
struct CAN_QUEUE_DATA TaskQueueImage[TASK_QUEUE_LENGTH_IMAGE] = {0};

struct CAN_QUEUE_DATA IMAGE_DATA_RX = {0,{0}};
struct CAN_QUEUE_DATA IMAGE_DATA_TX = {0,{0}};
struct StructQueue IMAGE_CAN_RX_QUEUE = {.pointRD = 0, .pointWR = 0, .queueLength = TASK_QUEUE_LENGTH_IMAGE, .queue = TaskQueueImage};
Picture pic1;
uint8_t cameraData[640] = {0};


// Vi skal have en funktion som bare tager et billede som kan kaldes af partcl


void CAM_init(CAM_HandleTypeDef *cam) {

	HAL_GPIO_WritePin(Transfer_pin_GPIO_Port, Transfer_pin_Pin, GPIO_PIN_RESET);

	// init SCCB
	CAM_setReg(cam, 0x12, 0x80); // Software reset, YUV mode
	HAL_Delay(20);
	CAM_setReg(cam, 0x1E, 0x31); // Flip image vertically and mirror image
	CAM_setReg(cam, 0x13, 0x81); // Fast algorithm and auto exposure enable
	CAM_setReg(cam, 0x3F, 0x01); // Edge enhancement factor
	CAM_setReg(cam, 0x71, 0xB5); // 8-bar color bar test pattern

	int a = CAM_getReg(cam, 0x12);
	int b = CAM_getReg(cam, 0x1E);
	int c = CAM_getReg(cam, 0x13);
	int d = CAM_getReg(cam, 0x3F);
	int e = CAM_getReg(cam, 0x71);

	//HAL_TIM_OC_Start(cam->DMATimer, TIM_CHANNEL_2); // Random kanal for at timeren altid kører
	__HAL_TIM_ENABLE_DMA(cam->DMATimer, TIM_DMA_CC3); // DENNE LINJE GJORDE AT DMA VILLE SIT LIV
	//HAL_GPIO_WritePin(Transfer_pin_GPIO_Port, Transfer_pin_Pin, GPIO_PIN_SET); // Transfer pin sættes høj
}

void CAM_startLineTransfer(CAM_HandleTypeDef *cam) {
	// init DMA
	//while (cam->requestDataTimer->Instance->CNT <=  3000) {}
	HAL_DMA_Start_IT(cam->hdma, cam->source, cam->destination, cam->pic->width);
	HAL_TIM_PWM_Start(cam->requestDataTimer, cam->requestDataChannel);

	cam->status = RECEIVING;
}

void CAM_stopLineTransfer(CAM_HandleTypeDef *cam) {
	// abort DMA
	HAL_DMA_Abort_IT(cam->hdma);
	//while (cam->requestDataTimer->Instance->CNT <= 3000) {}
	HAL_TIM_PWM_Stop(cam->requestDataTimer, cam->requestDataChannel);

	cam->status = WAITING;
}

void CAM_takePicture(CAM_HandleTypeDef *cam) {
	//HUSK at ændre i OBC-filen

	// Hvis ikke vi er ved at sende et billede, pulsér getImagePin på FPGA
	if (cam->status == STANDBY) {

		HAL_GPIO_WritePin(Get_image_pin_GPIO_Port, Get_image_pin_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(Get_image_pin_GPIO_Port, Get_image_pin_Pin, GPIO_PIN_RESET);
		osDelay(50);
		HAL_GPIO_WritePin(Transfer_pin_GPIO_Port, Transfer_pin_Pin, GPIO_PIN_SET);
		cam->status = READY;
	}
}

void CAM_toOutputQueue(CAM_HandleTypeDef *cam) {
	// Vent og placer pixel-koordinat-pakke i CAN-køen

	struct CAN_QUEUE_DATA package = {IMAGE_ID_COORDINATE, {
			(cam->pic->x & 0x00FF), (cam->pic->x >> 8),
			(cam->pic->y & 0x00FF), (cam->pic->y >> 8),
			(cam->pic->width & 0x00FF), (cam->pic->width >> 8),
			(cam->pic->height & 0x00FF), (cam->pic->height >> 8)}};

	while(!passToCanTX(&package)) {} // Vent på at der plads i CAN-køen til en pakke med 8 pixels


	package.ID = IMAGE_ID_DATA;

	for (; cam->pic->x < cam->pic->width;) { // Gentag indtil hele linjen er sendt / hele bufferen er tømt

		// Inkrementer x-positionen i Picture
		for (int i = 0; i < 8; i++, cam->pic->x++) {
			package.data[i] = *(cam->destination + cam->pic->x);
		}

		// Når der er plads, put dem i køen
		while (!passToCanTX(&package)) { }
	}

	// Opdater koordinaterne i Picture
	cam->pic->y++;
	cam->pic->x = 0;

	cam->status = READY;
}

void CAM_update(CAM_HandleTypeDef *cam) {
	if (cam->status == READY) {
		if (cam->pic->y < cam->pic->height) {
			CAM_startLineTransfer(cam);
		} else {
			cam->pic->x = 0;
			cam->pic->y = 0;
			cam->status = STANDBY;
			HAL_GPIO_WritePin(Transfer_pin_GPIO_Port, Transfer_pin_Pin, GPIO_PIN_RESET);

			struct CAN_QUEUE_DATA ImageCapturedPackage = {130, {"IMG DONE"}};
			while(!passToCanTX(&ImageCapturedPackage)) {}
		}
	} else if (cam->status == WAITING) {
		CAM_toOutputQueue(cam);
	}
}


void CAM_setReg(CAM_HandleTypeDef *cam, uint8_t reg_addr, uint8_t value) {
	uint8_t addrAndValue[2] = {reg_addr, value};
	uint8_t adressentest = cam->I2C_Address<<1;
	sem_HAL_I2C_Master_Transmit(cam->I2C_Handler, (cam->I2C_Address<<1), addrAndValue, 2, HAL_MAX_DELAY, &semaphr_I2C);
}

int CAM_getReg(CAM_HandleTypeDef *cam, int reg_addr) {
	int buf[1] = {reg_addr};
	sem_HAL_I2C_Master_Transmit(cam->I2C_Handler, (cam->I2C_Address<<1), buf, 1, HAL_MAX_DELAY, &semaphr_I2C);
	sem_HAL_I2C_Master_Receive(cam->I2C_Handler, (cam->I2C_Address<<1) | 0x01, buf, 1, HAL_MAX_DELAY, &semaphr_I2C);

	return buf[0];
}




void CAM_Handle_Init(CAM_HandleTypeDef *cam, DMA_HandleTypeDef *DMA_TimerChannel, TIM_HandleTypeDef *htim, I2C_HandleTypeDef *i2cHandle) {
    cam->I2C_Address = 0x21;
    cam->destination = cameraData;
    cam->hdma = DMA_TimerChannel;
    cam->pic = &pic1;
    cam->requestDataTimer = htim;
    cam->requestDataChannel = TIM_CHANNEL_1;
    cam->DMATimer = htim;
    cam->DMAChannel = TIM_CHANNEL_3;
    cam->source = &(GPIOA->IDR);
    cam->status = STANDBY;
    cam->I2C_Handler = i2cHandle;

    cam->pic->x = 0;
    cam->pic->y = 0;
    cam->pic->height = 480;
    cam->pic->width = 640;

}




void image(CAM_HandleTypeDef * cam){
	if (UnreadElements(&IMAGE_CAN_RX_QUEUE)){

		LeaveStructQueue(&IMAGE_CAN_RX_QUEUE, &IMAGE_DATA_RX);

		CAM_takePicture(cam);
	}

	while(cam->status != STANDBY){
		CAM_update(cam);
	}
}

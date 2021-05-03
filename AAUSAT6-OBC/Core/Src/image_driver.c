#include "image_driver.h"


uint32_t IMAGE_DATA_ID = 0x5;
struct CAN_QUEUE_DATA IMAGE_DATA_RX = {0,{0}};
struct CAN_QUEUE_DATA IMAGE_DATA_TX = {0,{0}};
struct StructQueue IMAGE_CAN_RX_QUEUE = {0};
Picture pic1;
uint8_t cameraData[650] = {0};


// Vi skal have en funktion som bare tager et billede som kan kaldes af partcl


void CAM_init(CAM_HandleTypeDef *cam) {
	// init SCCB
	CAM_setReg(cam, 0x12, 0x80); // Software reset, YUV mode
	CAM_setReg(cam, 0x1E, 0x31); // Flip image vertically and mirror image
	CAM_setReg(cam, 0x13, 0x81); // Fast algorithm and auto exposure enable
	CAM_setReg(cam, 0x3F, 0x01); // Edge enhancement factor
	//CAM_setReg(cam, 0x71, 0xB5); // 8-bar color bar test pattern
}

void CAM_startLineTransfer(CAM_HandleTypeDef *cam) {
	// init DMA
	while (cam->requestDataTimer->Instance->CNT <=  120) {}
	//HAL_GPIO_WritePin(GPIOA, GPIO_PIN_12, GPIO_PIN_SET);
	//int x0 = cam->requestDataTimer->Instance->CNT;
	HAL_DMA_Start_IT(cam->hdma, cam->source, cam->destination, cam->pic->width);
	//int x = cam->requestDataTimer->Instance->CNT;
	HAL_TIM_PWM_Start(cam->requestDataTimer, cam->requestDataChannel);
	//int x1 = cam->requestDataTimer->Instance->CNT;


	cam->status = RECEIVING;
}

void CAM_stopLineTransfer(CAM_HandleTypeDef *cam) {
	// abort DMA
	//int y0 = cam->requestDataTimer->Instance->CNT;
	HAL_DMA_Abort_IT(cam->hdma);
	//int y1 = cam->requestDataTimer->Instance->CNT;
	while (cam->requestDataTimer->Instance->CNT <= 120) {}
	//int y2 = cam->requestDataTimer->Instance->CNT;
	HAL_TIM_PWM_Stop(cam->requestDataTimer, cam->requestDataChannel);
	//int y3 = cam->requestDataTimer->Instance->CNT;
	//HAL_GPIO_WritePin(GPIOA, GPIO_PIN_12, GPIO_PIN_RESET);

	cam->status = WAITING;
}

void CAM_takePicture(CAM_HandleTypeDef *cam) {
	//HUSK at ændre i OBC-filen

	// Hvis ikke vi er ved at sende et billede, pulsér getImagePin på FPGA
	if (cam->status == STANDBY) {

		HAL_GPIO_WritePin(GPIOA, GPIO_PIN_8, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOA, GPIO_PIN_8, GPIO_PIN_RESET);
		HAL_Delay(50);
		cam->status = READY;
	}
}

int CAN_queuePackage(uint8_t *camData) {
	IMAGE_DATA_TX.ID = IMAGE_DATA_ID;
	for(int i = 0 ; i < PACKAGE_SIZE ; i++){
		IMAGE_DATA_TX.data[i] = camData[i];
	}
	return passToCanTX(&IMAGE_DATA_TX);

}

void CAM_toOutputQueue(CAM_HandleTypeDef *cam) {
	// Vent og placer pixel-koordinat-pakke i CAN-køen
	/*
	uint8_t coordinatePackage[8] = {(cam->pic->x & 0x00FF), (cam->pic->x >> 8),
									(cam->pic->y & 0x00FF), (cam->pic->y >> 8),
									(cam->pic->width & 0x00FF), (cam->pic->width >> 8),
									(cam->pic->height & 0x00FF), (cam->pic->height >> 8)};
	while(!CAN_queuePackage(CAN_ID_COORDINATE, coordinatePackage, 8)) {}
*/
	// Vent på at der plads i CAN-køen til en pakke med 8 pixels

	while(cam->pic->x < cam->pic->width) { // Gentag indtil hele linjen er sendt / hele bufferen er tømt
		// Når der er plads, put dem i køen
		if (CAN_queuePackage(cam->destination + cam->pic->x)) {
			// Inkrementer x-positionen i Picture
			cam->pic->x += 8;
		}
		/*
		else
		{
			HAL_Delay(1);
		}
		*/
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
			HAL_GPIO_WritePin(GPIOA, GPIO_PIN_12, RESET);
		}
	} else if (cam->status == WAITING) {
		CAM_toOutputQueue(cam);
	}
}


void CAM_setReg(CAM_HandleTypeDef *cam, uint8_t reg_addr, uint8_t value) {
	uint8_t addrAndValue[2] = {reg_addr, value};
	uint8_t adressentest = cam->I2C_Address<<1;
	HAL_I2C_Master_Transmit(cam->I2C_Handler, (cam->I2C_Address<<1), addrAndValue, 2, HAL_MAX_DELAY);
}

int CAM_getReg(CAM_HandleTypeDef *cam, int reg_addr) {
	int buf[1] = {reg_addr};
	HAL_I2C_Master_Transmit(cam->I2C_Handler, (cam->I2C_Address<<1), buf, 1, HAL_MAX_DELAY);
	HAL_I2C_Master_Receive(cam->I2C_Handler, (cam->I2C_Address<<1) | 0x01, buf, 1, HAL_MAX_DELAY);

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
	if(UnreadElements(&IMAGE_CAN_RX_QUEUE)){

		LeaveStructQueue(&IMAGE_CAN_RX_QUEUE, &IMAGE_DATA_RX);

		CAM_takePicture(cam);

		//todo: hcam bliver vist aldrig sat, og bør hellere blive givet som parameter i stedet for global variabel.

		while(cam->status != STANDBY){
			CAM_update(cam);
		}


	}else{

		return;
	}
}

/*
 * camera.c
 *
 *  Created on: Apr 16, 2021
 *      Author: joach
 */

#include "camera.h"
#include "main.h"

void CAM_init(CAM_HandleTypeDef *cam) {
	// init SCCB
	CAM_setReg(cam, 0x12, 0x80); // Software reset, YUV mode
	CAM_setReg(cam, 0x1E, 0x31); // Flip image vertically and mirror image
	CAM_setReg(cam, 0x13, 0x81); // Fast algorithm and auto exposure enable
	CAM_setReg(cam, 0x3F, 0x01); // Edge enhancement factor
	CAM_setReg(cam, 0x71, 0xB5); // 8-bar color bar test pattern
}

void CAM_startLineTransfer(CAM_HandleTypeDef *cam) {

	// init DMA
	//while (cam->requestDataTimer->Instance->CNT <=  50) {}
	HAL_DMA_Start_IT(cam->hdma, cam->source, cam->destination, cam->pic->width);
	HAL_TIM_PWM_Start(cam->requestDataTimer, cam->requestDataChannel);

	cam->status = RECEIVING;
}

void CAM_stopLineTransfer(CAM_HandleTypeDef *cam) {

	// abort DMA
	HAL_DMA_Abort_IT(cam->hdma);
	//while (cam->requestDataTimer->Instance->CNT <= 50) {}
	HAL_TIM_PWM_Stop(cam->requestDataTimer, cam->requestDataChannel);

  	cam->status = WAITING;
}

void CAM_update(CAM_HandleTypeDef *cam) {
	if (cam->status == READY) {
		if (cam->pic->y < cam->pic->height) {
			CAM_startLineTransfer(cam);
		} else {
			cam->pic->x = 0;
			cam->pic->y = 0;
			cam->status = STANDBY;
			HAL_GPIO_WritePin(GPIOB, GPIO_PIN_5, RESET);
		}
	} else if (cam->status == WAITING) {
		CAM_toOutputQueue(cam);
	}
}

void CAM_takePicture(CAM_HandleTypeDef *cam) {
	//HUSK at ændre i OBC-filen

	// Hvis ikke vi er ved at sende et billede, pulsér getImagePin på FPGA
	if (cam->status == STANDBY) {

		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);
		HAL_Delay(50);
		cam->status = READY;
	}
}

int CAN_queuePackage(uint32_t ID, uint8_t *data, uint32_t DLC) {}

void CAM_toOutputQueue(CAM_HandleTypeDef *cam) {
	// Vent og placer pixel-koordinat-pakke i CAN-køen
	uint8_t coordinatePackage[8] = {(cam->pic->x & 0x00FF), (cam->pic->x >> 8),
									(cam->pic->y & 0x00FF), (cam->pic->y >> 8),
									(cam->pic->width & 0x00FF), (cam->pic->width >> 8),
									(cam->pic->height & 0x00FF), (cam->pic->height >> 8)};
	while(!CAN_queuePackage(CAN_ID_COORDINATE, coordinatePackage, 8)) {}

	// Vent på at der plads i CAN-køen til en pakke med 8 pixels

	while(cam->pic->x < cam->pic->width) { // Gentag indtil hele linjen er sendt / hele bufferen er tømt
		// Når der er plads, put dem i køen
		if (CAN_queuePackage(CAN_ID_DATA, cam->destination + cam->pic->x, 8)) {
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

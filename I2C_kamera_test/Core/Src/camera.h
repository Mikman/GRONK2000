/*
 * camera.h
 *
 *  Created on: Apr 16, 2021
 *      Author: joachim
 */

#ifndef CAMERA_H_
#define CAMERA_H_

#include <stdint.h>
#include "stm32f1xx_hal.h"

#define CAN_ID_COORDINATE 32
#define CAN_ID_DATA 33



enum CAM_STATUS {
	READY,		// Når vi er klar til at modtage en ny linje
	RECEIVING,	// Når vi er i færd med at modtage nye pixels
	WAITING, 	// Når vi venter på plads i CAN-køen
	STANDBY		// Når vi ikke er igang med eller har planlagt noget
};

typedef struct {
	uint16_t x, y, width, height;
} Picture;

typedef struct {
	DMA_HandleTypeDef *hdma;
	TIM_HandleTypeDef *requestDataTimer;
	uint32_t requestDataChannel;
	Picture *pic;
	enum CAM_STATUS status;
	uint32_t *source;
	uint8_t *destination;
	uint8_t I2C_Address;
	I2C_HandleTypeDef *I2C_Handler;
} CAM_HandleTypeDef;



void CAM_init(CAM_HandleTypeDef *cam);
void CAM_update(CAM_HandleTypeDef *cam);
void CAM_setReg(CAM_HandleTypeDef *cam, uint8_t reg_addr, uint8_t value);
int CAM_getReg(CAM_HandleTypeDef *cam, int reg_addr);
void CAM_startLineTransfer(CAM_HandleTypeDef *cam);
void CAM_stopLineTransfer(CAM_HandleTypeDef *cam);
void CAM_takePicture(CAM_HandleTypeDef *cam);
void CAM_toOutputQueue(CAM_HandleTypeDef *cam);


#endif /* CAMERA_H_ */

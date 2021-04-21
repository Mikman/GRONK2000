/*
 * Transmit_driver.h
 *
 *  Created on: Apr 14, 2021
 *      Author: micha
 */

#ifndef SRC_TRANSMIT_DRIVER_H_
#define SRC_TRANSMIT_DRIVER_H_

#include "stm32f1xx_hal.h"
#include "string.h"
#include "stdio.h"
#include "gpsdriver.h"
#include "mpu6050_driver.h"
#include "DCMotordriver.h"



void sendGPS(CAN_HandleTypeDef *handler, CAN_TxHeaderTypeDef *transmitHeader);

void sendMCU(CAN_HandleTypeDef *handler, CAN_TxHeaderTypeDef *transmitHeader);

void sendDCMotor(CAN_HandleTypeDef *handler, CAN_TxHeaderTypeDef *transmitHeader);

int messageSplitter(uint8_t *sourceArray, uint8_t *destinationArray, uint8_t position);

void sendData(CAN_HandleTypeDef *handler, uint32_t TxID, uint16_t numOfBytes, uint8_t *dataArray, CAN_TxHeaderTypeDef *transmitHeader);

void floatTo4UIntArray(float floatData, uint8_t *destinationArray);

#endif /* SRC_TRANSMIT_DRIVER_H_ */
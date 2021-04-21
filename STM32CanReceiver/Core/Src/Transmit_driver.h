/*
 * Transmit_driver.h
 *
 *  Created on: Apr 14, 2021
 *      Author: micha
 */

#ifndef SRC_TRANSMIT_DRIVERH
#define SRC_TRANSMIT_DRIVERH

#include "stm32l4xx_hal.h"
#include "string.h"
#include "stdio.h"


int messageSplitter(uint8_t *sourceArray, uint8_t *destinationArray, uint8_t position);

void sendData(CAN_HandleTypeDef *handler, uint32_t TxID, uint16_t numOfBytes, uint8_t *dataArray, CAN_TxHeaderTypeDef *transmitHeader);

void floatTo4UIntArray(float floatData, uint8_t destinationArray);

#endif / SRC_TRANSMIT_DRIVERH */

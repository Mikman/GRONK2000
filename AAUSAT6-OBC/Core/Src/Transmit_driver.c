/*
 * Transmit.c
 *
 *  Created on: Apr 14, 2021
 *      Author: Michael
 */


#include "circle_queue.h"
#include "transmit_driver.h"
#include "gpsdriver.h"
#include "DCMotorDriver.h"
#include "mpu6050_driver.h"
#include "stdbool.h"
extern GPS_FIX_DATA data;
extern Axes3 resultGyro;
extern Axes3 resultAccel;
extern float tempVal;
extern uint32_t ARR;
extern uint32_t CaptureDCMotor;
extern bool CAN_Mailbox0Empty;
extern bool CAN_Mailbox1Empty;
extern bool CAN_Mailbox2Empty;


struct Queue queueRAM = {0, 0, {0}};
struct Queue queueRx = {0, 0, {0}};

void transmit_driver_init() {
	semaphr_send = xSemaphoreCreateMutex();
	if (semaphr_send == NULL) Error_Handler();

	semaphr_I2C = xSemaphoreCreateMutex();
	if (semaphr_I2C == NULL) Error_Handler();
}

void floatTo4UIntArray(float floatData, uint8_t *destinationArray){
	uint8_t *ptr;
	ptr = (uint8_t *)(&floatData);

	for(int i = 0; i<4; i++){
		destinationArray[i] = ptr[i];
	}

}

int hvorErJeg = 0;

int sendData(CAN_HandleTypeDef *handler, uint32_t TxID, uint16_t numOfBytes,
		uint8_t *dataArray, CAN_TxHeaderTypeDef *transmitHeader, int ISR) {

	if(ISR == 0 && !xSemaphoreTake(semaphr_send, 0)){
		hvorErJeg = -2;
		return 0;
	}

	if (HAL_CAN_GetTxMailboxesFreeLevel(handler) == 0) {
		if (ISR == 0 && !xSemaphoreGive(semaphr_send)) Error_Handler();
		return 0;
	}

	uint8_t dataToMB[PACKAGE_SIZE] = { 0 };
	uint32_t randoMailBox;
	transmitHeader->ExtId = TxID;
	uint32_t tsr = READ_REG(handler->Instance->TSR);

	if (numOfBytes % PACKAGE_SIZE == 0) {
		for (int i = 0; i < numOfBytes / PACKAGE_SIZE; i++) {
			if (messageSplitter(dataArray, dataToMB, i)) {

				if (HAL_CAN_AddTxMessage(handler, transmitHeader, dataToMB,
						&randoMailBox) != HAL_OK) {
					Error_Handler();
				}
			}
		}
	}

	if (ISR == 0 && !xSemaphoreGive(semaphr_send)) Error_Handler();

	return 1;
}

int messageSplitter(uint8_t *sourceArray, uint8_t *destinationArray, uint8_t position)
{



	for(int i=0 ; i < PACKAGE_SIZE; i++)
	{
		*(destinationArray + i) = *(sourceArray + (position * 8) + i);


}
return 1;
}

HAL_StatusTypeDef sem_HAL_I2C_Master_Transmit(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout, SemaphoreHandle_t *sem) {
	HAL_StatusTypeDef returnValue = HAL_ERROR;
	if (xSemaphoreTake(*sem, SEMAPHR_WAIT_TIME) == pdPASS) {
		returnValue = HAL_I2C_Master_Transmit(hi2c, DevAddress, pData, Size, Timeout);
		xSemaphoreGive(*sem);
	}
	return returnValue;
}

HAL_StatusTypeDef sem_HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout, SemaphoreHandle_t *sem) {
	HAL_StatusTypeDef returnValue = HAL_ERROR;
		if (xSemaphoreTake(*sem, SEMAPHR_WAIT_TIME) == pdPASS) {
			returnValue = HAL_I2C_Master_Receive(hi2c, DevAddress, pData, Size, Timeout);
			xSemaphoreGive(*sem);
		}
		return returnValue;
}

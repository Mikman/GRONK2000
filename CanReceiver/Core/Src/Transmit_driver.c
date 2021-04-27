/*
 * Transmit.c
 *
 *  Created on: Apr 14, 2021
 *      Author: Michael
 */


#include "circle_queue.h"
#include "transmit_driver.h"

/* USER CODE BEGIN PV */
struct Queue queueRAM = {0, 0, {0}};
struct Queue queueRx = {0, 0, {0}};
#define PACKAGE_SIZE 8


/* USER CODE END PV */

void sendData(CAN_HandleTypeDef *handler, uint32_t TxID, uint16_t numOfBytes, uint8_t *dataArray, CAN_TxHeaderTypeDef *transmitHeader) {
	uint8_t dataToMB[PACKAGE_SIZE] = {0};
	uint32_t randoMailBox;
	transmitHeader->ExtId = TxID;

if (numOfBytes % PACKAGE_SIZE == 0)
{
	for (int i = 0; i < numOfBytes/PACKAGE_SIZE; i++) {
		 HAL_CAN_StateTypeDef state = handler->State;
		while (HAL_CAN_GetTxMailboxesFreeLevel(handler) == 0) {}
		if (messageSplitter(dataArray, dataToMB, i)) {
			if (HAL_CAN_AddTxMessage(handler, transmitHeader, dataToMB, &randoMailBox) != HAL_OK) {
				Error_Handler();

			}
		}
	}

}
else {return 0;}

}

int messageSplitter(uint8_t *sourceArray, uint8_t *destinationArray, uint8_t position)
{



	for(int i=0 ; i < PACKAGE_SIZE; i++)
	{
		*(destinationArray + i) = *(sourceArray + (position * 8) + i);


}
return 1;
}

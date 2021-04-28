

#ifndef CAN_DRIVER_H
#define CAN_DRIVER_H



#include "stdio.h"
#include "string.h"
#include <stdlib.h>
#include "stm32l4xx_hal.h"
#include "stdbool.h"
#include "circle_queue_struct.h"
#include "Transmit_driver.h"

void can_init(CAN_HandleTypeDef *hcan, CAN_RxHeaderTypeDef *CANRX, CAN_TxHeaderTypeDef *CANTX, UART_HandleTypeDef *UART);

void HAL_CAN_TxMailbox0CompleteCallback(CAN_HandleTypeDef *hcan);

void HAL_CAN_TxMailbox1CompleteCallback(CAN_HandleTypeDef *hcan);

void HAL_CAN_TxMailbox2CompleteCallback(CAN_HandleTypeDef *hcan);

void placeData_1(uint8_t *p);

void receiveData();

void passToCanTX(struct CAN_QUEUE_DATA *data);


#endif /* CAN_DRIVER_H */

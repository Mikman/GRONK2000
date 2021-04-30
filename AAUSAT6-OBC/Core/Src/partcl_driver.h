/*
 * partcl_driver.h
 *
 *  Created on: 20. apr. 2021
 *      Author: Mikkel
 */

#ifndef SRC_PARTCL_DRIVER_H_
#define SRC_PARTCL_DRIVER_H_

#include "stm32l4xx_hal.h"
#include "partcl_interpreter.h"
#include <string.h>
#include <stdlib.h>
#include "can_driver.h"
#include "FreeRTOS.h"
#include "task.h"

#define BUF_SIZE_IN 128
#define BUF_SIZE_OUT 512

#define CAN_ID_PARTCL_INPUT 64
#define CAN_ID_PARTCL_OUTPUT 65

void partcl_init();

void partcl_execute();

void partcl_add_program(char * str, size_t size);

char partcl_getInputChar();

void partcl_printf(const char *str);

#endif /* SRC_PARTCL_DRIVER_H_ */

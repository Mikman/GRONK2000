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
#include <stdio.h>
#include <string.h>

#define BUF_SIZE_IN 128
#define BUF_SIZE_OUT 512

void partcl_init();

void partcl_update();

char partcl_getInputChar();

void partcl_printf(char *str);

#endif /* SRC_PARTCL_DRIVER_H_ */

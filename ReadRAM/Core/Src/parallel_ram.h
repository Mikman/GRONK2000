/*
 * parallel_ram.h
 *
 *  Created on: Mar 15, 2021
 *      Author: Mikkel
 */

#ifndef SRC_PARALLEL_RAM_H_
#define SRC_PARALLEL_RAM_H_

#include "stm32f1xx_hal.h"

#define READ_RAM_EXT_INT_PIN 0

unsigned int ReadRamData();

void ReadRam_Init();

void LoadData_Callback();

#endif /* SRC_PARALLEL_RAM_H_ */

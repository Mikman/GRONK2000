/*
 * DCMotorDriver.h
 *
 *  Created on: Apr 1, 2021
 *      Author: Mikkel
 */

#ifndef SRC_DCMOTORDRIVER_H_
#define SRC_DCMOTORDRIVER_H_

#include "main.h"

void motor_init(TIM_HandleTypeDef *htimer, uint32_t channel);

void motor_setPwm(uint8_t dutycycle);

void motor_start(int8_t dutycycle);

void motor_stop();

#endif /* SRC_DCMOTORDRIVER_H_ */

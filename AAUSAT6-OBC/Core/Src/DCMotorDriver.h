/*
 * DCMotorDriver.h
 *
 *  Created on: Apr 1, 2021
 *      Author: Mikkel
 */

#ifndef SRC_DCMOTORDRIVER_H_
#define SRC_DCMOTORDRIVER_H_

#define MOTOR_ID_CTRL 4

#include "main.h"
#include "circle_queue_struct.h"
#include "can_driver.h"

void motor_init(TIM_HandleTypeDef *htimer, uint32_t channel);

void motor_setPwm(float dutycycle);

void motor_setSpeed(uint8_t speed);

float motor_speedToDutycycle(uint8_t speed);

void motor_start(uint8_t speed, char dir);

void motor_stop();

float motor_measure_dutycycle();

uint8_t motor_measure_direction();

void motor_setDirection(char dir);

void motor();

#endif /* SRC_DCMOTORDRIVER_H_ */

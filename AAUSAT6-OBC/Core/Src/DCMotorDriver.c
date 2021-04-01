#include "DCMotorDriver.h"

TIM_HandleTypeDef * htim;
uint32_t timer_channel = 0;

void motor_init(TIM_HandleTypeDef *htimer, uint32_t channel) {
	htim = htimer;
	timer_channel = channel;
	motor_setPwm(20);
}

void motor_setPwm(uint8_t dutycycle) {
	htim->Instance->CCR1 = (htim->Instance->ARR/100)*dutycycle;
}

void motor_start(int8_t dutycycle) {
	if (dutycycle >= 0) motor_setPwm(dutycycle);

	HAL_TIM_PWM_Start(htim, timer_channel);
}

void motor_stop() {
	HAL_TIM_PWM_Stop(htim, timer_channel);
}

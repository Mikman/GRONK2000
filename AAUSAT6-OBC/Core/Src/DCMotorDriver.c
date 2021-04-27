#include "DCMotorDriver.h"

TIM_HandleTypeDef * htim;
uint32_t timer_channel = 0;
uint32_t CaptureDCMotor = 0;
uint32_t ARR = 0;

uint32_t MOTOR_DATA_ID = 0x3;
struct CAN_QUEUE_DATA MOTOR_DATA = {0,{0}};
struct StructQueue MOTOR_CAN_RX_QUEUE = {0};


void motor_init(TIM_HandleTypeDef *htimer, uint32_t channel) {
	htim = htimer;
	timer_channel = channel;
	motor_setPwm(20);
}

void motor_setPwm(uint8_t dutycycle) {
	CaptureDCMotor = htim->Instance->CCR1;
	ARR = htim->Instance->ARR;
	htim->Instance->CCR1 = (htim->Instance->ARR/100)*dutycycle;
}

void motor_start(int8_t dutycycle) {
	if (dutycycle >= 0) motor_setPwm(dutycycle);

	HAL_TIM_PWM_Start(htim, timer_channel);
}

void motor_stop() {
	HAL_TIM_PWM_Stop(htim, timer_channel);
}

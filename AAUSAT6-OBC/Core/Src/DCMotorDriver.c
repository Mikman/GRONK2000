#include "DCMotorDriver.h"

TIM_HandleTypeDef *htim;
uint32_t timer_channel = 0;
uint32_t CaptureDCMotor = 0;
uint32_t ARR = 0;

#define TASK_QUEUE_LENGTH_MOTOR 2
struct CAN_QUEUE_DATA taskQueueMotor[TASK_QUEUE_LENGTH_MOTOR] = {0};

struct CAN_QUEUE_DATA MOTOR_DATA_RX = { 0, { 0 } };
struct CAN_QUEUE_DATA MOTOR_DATA_TX = { 0, { 0 } };
struct StructQueue MOTOR_CAN_RX_QUEUE = {.pointRD = 0, .pointWR = 0, .queueLength =  TASK_QUEUE_LENGTH_MOTOR, .queue = taskQueueMotor};

void motor_init(TIM_HandleTypeDef *htimer, uint32_t channel) {
	htim = htimer;
	timer_channel = channel;
}

void motor_setPwm(uint8_t dutycycle) {
	if (dutycycle > 100)
		dutycycle = 100;
	ARR = htim->Instance->ARR;
	htim->Instance->CCR2 = (htim->Instance->ARR / 100) * dutycycle;
}

void motor_start(int8_t dutycycle) {
	if (dutycycle >= 0)
		motor_setPwm(dutycycle);

	HAL_TIM_PWM_Start(htim, timer_channel);
}

void motor_stop() {
	HAL_TIM_PWM_Stop(htim, timer_channel);
	//Fast motot stop
	HAL_GPIO_WritePin(DC_motor_Dir1_GPIO_Port, DC_motor_Dir1_Pin, GPIO_PIN_SET);
	HAL_GPIO_WritePin(DC_motor_Dir2_GPIO_Port, DC_motor_Dir2_Pin, GPIO_PIN_SET);
}

float motor_meassure_dutycycle() {
	float dutycycle = 0.;
	dutycycle = (htim->Instance->CCR2) / (htim->Instance->ARR / 100);
	return dutycycle;
}

uint8_t motor_meassure_direction() {
	if (HAL_GPIO_ReadPin(DC_motor_Dir1_GPIO_Port, DC_motor_Dir1_Pin)
			&& !HAL_GPIO_ReadPin(DC_motor_Dir2_GPIO_Port, DC_motor_Dir2_Pin)) {
		return 'R';
	} else if (!HAL_GPIO_ReadPin(DC_motor_Dir1_GPIO_Port, DC_motor_Dir1_Pin)
			&& HAL_GPIO_ReadPin(DC_motor_Dir2_GPIO_Port, DC_motor_Dir2_Pin)) {
		return 'L';
	} else {
		return 3;
	}

}

void motor_direction(char dir) {
	if (dir == 'R') {
		HAL_GPIO_WritePin(DC_motor_Dir1_GPIO_Port, DC_motor_Dir1_Pin,
				GPIO_PIN_SET);
		HAL_GPIO_WritePin(DC_motor_Dir2_GPIO_Port, DC_motor_Dir2_Pin,
				GPIO_PIN_RESET);
	}
	if (dir == 'L') {
		HAL_GPIO_WritePin(DC_motor_Dir2_GPIO_Port, DC_motor_Dir2_Pin,
				GPIO_PIN_SET);
		HAL_GPIO_WritePin(DC_motor_Dir1_GPIO_Port, DC_motor_Dir1_Pin,
				GPIO_PIN_RESET);
	}

}

void motor() {
	if (UnreadElements(&MOTOR_CAN_RX_QUEUE)) {

		LeaveStructQueue(&MOTOR_CAN_RX_QUEUE, &MOTOR_DATA_RX);
		uint8_t direction;
		float dutycycle;

		if ((MOTOR_DATA_RX.data[7] > 0) && (MOTOR_DATA_RX.data[7] <= 100)) {
			motor_start(MOTOR_DATA_RX.data[7]);
		}

		if (MOTOR_DATA_RX.data[4] > 0) {
			dutycycle = motor_meassure_dutycycle();
			direction = motor_meassure_direction();
			MOTOR_DATA_TX.ID = 36;

		}
		if (MOTOR_DATA_RX.data[5] > 0) {
			motor_stop();
		}

		if (MOTOR_DATA_RX.data[6] == 'R') {
			motor_direction('R');
		} else if (MOTOR_DATA_RX.data[6] == 'L') {
			motor_direction('L');
		}

		floatTo4UIntArray(dutycycle, MOTOR_DATA_TX.data);
		MOTOR_DATA_TX.data[4] = direction;

		passToCanTX(&MOTOR_DATA_TX);

	} else {

		return;
	}
}

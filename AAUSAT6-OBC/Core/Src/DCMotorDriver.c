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

void motor_setSpeed(uint8_t speed) {
	if (speed == 0) motor_setPwm(0);
	else motor_setPwm(motor_speedToDutycycle(speed));
}

uint8_t motor_speedToDutycycle(uint8_t speed) {
	if (speed > 100) speed = 100;

	float sf = (speed / 100.0f);

	float df = 2.0182f * (sf * sf * sf) - 1.8073f * (sf * sf) + 0.704f * sf + 0.1155f;

	int8_t dutycycle = df * 100;

	if (dutycycle > 100) dutycycle = 100;
	if (dutycycle < 0) dutycycle = 0;

	return (uint8_t) dutycycle;
}

void motor_start(int8_t speed, char dir) {
	if (speed >= 0)
		motor_setSpeed(speed);
	motor_setDirection(dir);

	HAL_TIM_PWM_Start(htim, timer_channel);
}

void motor_stop() {
	HAL_TIM_PWM_Stop(htim, timer_channel);
	//Fast motor stop
	HAL_GPIO_WritePin(DC_motor_Dir1_GPIO_Port, DC_motor_Dir1_Pin, GPIO_PIN_SET);
	HAL_GPIO_WritePin(DC_motor_Dir2_GPIO_Port, DC_motor_Dir2_Pin, GPIO_PIN_SET);
}

float motor_measure_dutycycle() {
	float dutycycle = 0.;
	dutycycle = (htim->Instance->CCR2) / (htim->Instance->ARR / 100);
	return dutycycle;
}

uint8_t motor_measure_direction() {
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

void motor_setDirection(char dir) {
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
		uint8_t measurementIsNeeded = 0;

		if ((MOTOR_DATA_RX.data[7] > 0) && (MOTOR_DATA_RX.data[7] <= 100)) {
			motor_start(MOTOR_DATA_RX.data[7], MOTOR_DATA_RX.data[6]);
		}
		if (MOTOR_DATA_RX.data[4] > 0) {
			dutycycle = motor_measure_dutycycle();
			direction = motor_measure_direction();
			MOTOR_DATA_TX.ID = 36;
			measurementIsNeeded = 1;
		}
		if (MOTOR_DATA_RX.data[5] > 0) {
			motor_stop();
		}

		floatTo4UIntArray(dutycycle, MOTOR_DATA_TX.data);
		MOTOR_DATA_TX.data[4] = direction;

		if (measurementIsNeeded) passToCanTX(&MOTOR_DATA_TX);

	} else {

		return;
	}
}

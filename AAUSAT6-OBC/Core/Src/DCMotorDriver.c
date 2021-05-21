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

void motor_setPwm(float dutycycle) {
	if (dutycycle > 1.0f)
		dutycycle = 1.0f;
	ARR = htim->Instance->ARR;
	htim->Instance->CCR2 = (uint32_t)((htim->Instance->ARR) * dutycycle);

}

void motor_setSpeed(uint8_t speed) {
	if (speed == 0) motor_setPwm(0);
	else motor_setPwm(motor_speedToDutycycle(speed));
}

float motor_speedToDutycycle(uint8_t speed) {
	if (speed >= 100) return 1.0f;

	float sf = (speed / 100.0f);

	float dutycycle = -0.0621f * (sf * sf * sf * sf) + 1.3689f * (sf * sf * sf) - 0.6872f * (sf * sf) + 0.2987f * sf + 0.0608f;


	if (dutycycle > 1.0f) dutycycle = 1.0f;
	if (dutycycle < 0.0f) dutycycle = 0.0f;

	return dutycycle;
}

void motor_start(uint8_t speed, char dir) {
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
	float dutycycle = 0.0f;
	dutycycle =  ((float)htim->Instance->CCR2) / ((float)htim->Instance->ARR);
	dutycycle *= 100.0f;
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

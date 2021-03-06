/*
 * mpu6050_driver.h
 *
 *  Created on: Apr 5, 2021
 *      Author: Sophu
 */

#ifndef SRC_MPU6050_DRIVER_H_
#define SRC_MPU6050_DRIVER_H_

#define MPU_ID_CTRL 0

#include "main.h"

#include "string.h"
#include "stdio.h"
#include "circle_queue_struct.h"
#include "can_driver.h"
#include "transmit_driver.h"

// I2C device addresses
static const uint8_t MPU_Address = 0x68;

//Register used for MPU initialization
static const uint8_t SIGNAL_PATH_RESET = 0x68; //Resets the analog and digital signal paths of the gyroscope, accelerometer, and temperature sensors.
static const uint8_t MPU_PWR_MGT_1 = 0x6B; // Power management 1
static const uint8_t DLPF_CFG = 0x1A;  // Config register read/write
static const uint8_t SMPLRT_DIV = 0x19;  // Sample divider to achieve a desired sample rate
static const uint8_t GYRO_CONFIG = 0x1B;  // Gyroscope scale config - degrees per second
static const uint8_t GYRO_CONFIG_SCALE = 0x18; // 0x00 = 250 degrees/second, 0x08 = 500 degrees/second, 0x10 = 1000 degrees/second, 0x18 = 2000 degrees/second
static const uint8_t ACCEL_CONFIG = 0x1C;  // Accelerometer scale config - degrees per second
static const uint8_t ACCEL_CONFIG_SCALE = 0x18; // 0x00 = 2g, 0x08 = 4g, 0x10 = 8g, 0x18 = 16g

// MPU Read registers
static const uint8_t MPU_TempReg = 0x41;
static const uint8_t MPU_GyroOut = 0x43;
static const uint8_t MPU_AccelOut = 0x3B;

typedef struct {
	float x;
	float y;
	float z;
} Axes3;

HAL_StatusTypeDef MPU_Init(I2C_HandleTypeDef * I2C_handler);

float MPU_Read_Temp();

Axes3 MPU_Read_Gyro();

Axes3 MPU_Read_Accel();

void MPU6050();

#endif /* SRC_MPU6050_DRIVER_H_ */

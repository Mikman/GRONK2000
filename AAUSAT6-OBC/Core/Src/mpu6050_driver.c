#include "mpu6050_driver.h"
I2C_HandleTypeDef * hi2c1;

HAL_StatusTypeDef MPU_Init(I2C_HandleTypeDef * I2C_handler){
	hi2c1 = I2C_handler;
	HAL_StatusTypeDef returnValue;
	uint8_t initializationBuffer[5];

	initializationBuffer[0] = MPU_PWR_MGT_1;
	initializationBuffer[1] = 0x00; //Set clocksource to internal 8MHz oscillator
	returnValue = HAL_I2C_Master_Transmit(I2C_handler, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = SIGNAL_PATH_RESET;
	initializationBuffer[1] = 0x07; // Resets gyro, accel & temp signal path to disable any filtering
	returnValue = HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = DLPF_CFG;
	initializationBuffer[1] = 0x00; //Digital low pass filter disable & gyro sample rate at 8 kHz
	returnValue = HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = SMPLRT_DIV;
	initializationBuffer[1] = 0x07; //Sample Rate = Gyroscope Output Rate / (1 + SMPLRT_DIV)  @ 1kHz
	returnValue = HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = GYRO_CONFIG;
	initializationBuffer[1] = GYRO_CONFIG_SCALE; // Sets the full scale to +-2000 degrees per second
	returnValue = HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = ACCEL_CONFIG;
	initializationBuffer[1] = ACCEL_CONFIG_SCALE; // Sets the accelerometer full scale to +-16g
	returnValue = HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;


	return returnValue;


}

float MPU_Read_Temp(){
	// Enumeration of possible errors
	HAL_StatusTypeDef returnValue;
	int16_t rawTempVal;
	float tempVal = 0.0;

	uint8_t tempBuf[2];
	 tempBuf[0] = MPU_TempReg;
	 returnValue = HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), tempBuf, 1, HAL_MAX_DELAY);
	 if(returnValue != HAL_OK) return returnValue;
	 returnValue = HAL_I2C_Master_Receive(hi2c1, (MPU_Address<<1) | 0x01, tempBuf, 2, HAL_MAX_DELAY);
	 if(returnValue != HAL_OK) return returnValue;

	 // Data composition from raw data
	 rawTempVal = ((int16_t)tempBuf[0] << 8 | tempBuf[1]);

	 // Temperature calculation
	 tempVal = (rawTempVal)/340.0 + 36.53;

	 return tempVal;
}

float MPU_Read_Gyro(char axis){
	int16_t rawGyroData_X;
	int16_t rawGyroData_Y;
	int16_t rawGyroData_Z;

	float gyro_X;
	float gyro_Y;
	float gyro_Z;

	float sensitivity;

	if (GYRO_CONFIG_SCALE == 0x00)sensitivity =  131.0;
	if (GYRO_CONFIG_SCALE == 0x08)sensitivity =  65.5;
	if (GYRO_CONFIG_SCALE == 0x10)sensitivity =  32.8;
	if (GYRO_CONFIG_SCALE == 0x18)sensitivity =  16.4;

	 uint8_t gyroBuf[10];
	 gyroBuf[0] = MPU_GyroOut;
	 HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), gyroBuf, 1, HAL_MAX_DELAY);
	 HAL_I2C_Master_Receive(hi2c1, (MPU_Address<<1) | 0x01, gyroBuf, 6, HAL_MAX_DELAY);

	 // Data composition from raw data
	 rawGyroData_X = ((int16_t)gyroBuf[0] << 8 | gyroBuf[1]);
	 rawGyroData_Y = ((int16_t)gyroBuf[2] << 8 | gyroBuf[3]);
	 rawGyroData_Z = ((int16_t)gyroBuf[4] << 8 | gyroBuf[5]);

	 gyro_X = (float)rawGyroData_X/sensitivity;
	 gyro_Y = (float)rawGyroData_Y/sensitivity;
	 gyro_Z = (float)rawGyroData_Z/sensitivity;

	 if ((axis == 'X') | (axis == 'x'))return gyro_X;
	 if ((axis == 'Y') | (axis == 'y'))return gyro_Y;
	 if ((axis == 'Z') | (axis == 'z'))return gyro_Z;
	 else return 0.0;

}


float MPU_Read_Accel(char axis){
	int16_t rawAccelData_X;
	int16_t rawAccelData_Y;
	int16_t rawAccelData_Z;

	float accel_X;
	float accel_Y;
	float accel_Z;

	float sensitivity;

	if (ACCEL_CONFIG_SCALE == 0x00)sensitivity =  16384.0;
	if (ACCEL_CONFIG_SCALE == 0x08)sensitivity =  8192.0;
	if (ACCEL_CONFIG_SCALE == 0x10)sensitivity =  4096.0;
	if (ACCEL_CONFIG_SCALE == 0x18)sensitivity =  2048.0;

	 uint8_t accelBuf[10];
	 accelBuf[0] = MPU_AccelOut;
	 HAL_I2C_Master_Transmit(hi2c1, (MPU_Address<<1), accelBuf, 1, HAL_MAX_DELAY);
	 HAL_I2C_Master_Receive(hi2c1, (MPU_Address<<1) | 0x01, accelBuf, 6, HAL_MAX_DELAY);

	 // Data composition from raw data
	 rawAccelData_X = ((int16_t)accelBuf[0] << 8 | accelBuf[1]);
	 rawAccelData_Y = ((int16_t)accelBuf[2] << 8 | accelBuf[3]);
	 rawAccelData_Z = ((int16_t)accelBuf[4] << 8 | accelBuf[5]);

	 accel_X = (float)rawAccelData_X/sensitivity;
	 accel_Y = (float)rawAccelData_Y/sensitivity;
	 accel_Z = (float)rawAccelData_Z/sensitivity;

	 if ((axis == 'X') | (axis == 'x'))return accel_X;
	 if ((axis == 'Y') | (axis == 'y'))return accel_Y;
	 if ((axis == 'Z') | (axis == 'z'))return accel_Z;
	 else return 0.0;

}



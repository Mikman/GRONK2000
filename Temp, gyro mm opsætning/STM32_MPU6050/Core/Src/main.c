/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

#include "string.h"
#include "i2c-lcd.h"
#include "stdio.h"



/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
I2C_HandleTypeDef hi2c1;
I2C_HandleTypeDef hi2c2;

/* USER CODE BEGIN PV */

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




/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_I2C1_Init(void);
static void MX_I2C2_Init(void);
/* USER CODE BEGIN PFP */

HAL_StatusTypeDef MPU_Init(){
	HAL_StatusTypeDef returnValue;
	uint8_t initializationBuffer[5];

	initializationBuffer[0] = MPU_PWR_MGT_1;
	initializationBuffer[1] = 0x00; //Set clocksource to internal 8MHz oscillator
	returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = SIGNAL_PATH_RESET;
	initializationBuffer[1] = 0x07; // Resets gyro, accel & temp signal path to disable any filtering
	returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = DLPF_CFG;
	initializationBuffer[1] = 0x00; //Digital low pass filter disable & gyro sample rate at 8 kHz
	returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = SMPLRT_DIV;
	initializationBuffer[1] = 0x07; //Sample Rate = Gyroscope Output Rate / (1 + SMPLRT_DIV)  @ 1kHz
	returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = GYRO_CONFIG;
	initializationBuffer[1] = GYRO_CONFIG_SCALE; // Sets the full scale to +-2000 degrees per second
	returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
	if(returnValue != HAL_OK) return returnValue;

	initializationBuffer[0] = ACCEL_CONFIG;
	initializationBuffer[1] = ACCEL_CONFIG_SCALE; // Sets the accelerometer full scale to +-16g
	returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), initializationBuffer, 2, HAL_MAX_DELAY);
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
	 returnValue = HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), tempBuf, 1, HAL_MAX_DELAY);
	 if(returnValue != HAL_OK) return returnValue;
	 returnValue = HAL_I2C_Master_Receive(&hi2c1, (MPU_Address<<1) | 0x01, tempBuf, 2, HAL_MAX_DELAY);
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
	 HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), gyroBuf, 1, HAL_MAX_DELAY);
	 HAL_I2C_Master_Receive(&hi2c1, (MPU_Address<<1) | 0x01, gyroBuf, 6, HAL_MAX_DELAY);

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
	 HAL_I2C_Master_Transmit(&hi2c1, (MPU_Address<<1), accelBuf, 1, HAL_MAX_DELAY);
	 HAL_I2C_Master_Receive(&hi2c1, (MPU_Address<<1) | 0x01, accelBuf, 6, HAL_MAX_DELAY);

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
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */



  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_I2C1_Init();
  MX_I2C2_Init();
  /* USER CODE BEGIN 2 */

  lcd_init();

  MPU_Init();


  //lcd_send_string("Hello World");

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {

	  float accel = MPU_Read_Accel('z');

	  char buf[20];
	  sprintf(buf, "%f", accel);

	  lcd_put_cur(0, 0);
	  lcd_send_string(buf);
	  HAL_Delay(200);


    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
  * @brief I2C1 Initialization Function
  * @param None
  * @retval None
  */
static void MX_I2C1_Init(void)
{

  /* USER CODE BEGIN I2C1_Init 0 */

  /* USER CODE END I2C1_Init 0 */

  /* USER CODE BEGIN I2C1_Init 1 */

  /* USER CODE END I2C1_Init 1 */
  hi2c1.Instance = I2C1;
  hi2c1.Init.ClockSpeed = 100000;
  hi2c1.Init.DutyCycle = I2C_DUTYCYCLE_2;
  hi2c1.Init.OwnAddress1 = 0;
  hi2c1.Init.AddressingMode = I2C_ADDRESSINGMODE_7BIT;
  hi2c1.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
  hi2c1.Init.OwnAddress2 = 0;
  hi2c1.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
  hi2c1.Init.NoStretchMode = I2C_NOSTRETCH_DISABLE;
  if (HAL_I2C_Init(&hi2c1) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN I2C1_Init 2 */

  /* USER CODE END I2C1_Init 2 */

}

/**
  * @brief I2C2 Initialization Function
  * @param None
  * @retval None
  */
static void MX_I2C2_Init(void)
{

  /* USER CODE BEGIN I2C2_Init 0 */

  /* USER CODE END I2C2_Init 0 */

  /* USER CODE BEGIN I2C2_Init 1 */

  /* USER CODE END I2C2_Init 1 */
  hi2c2.Instance = I2C2;
  hi2c2.Init.ClockSpeed = 100000;
  hi2c2.Init.DutyCycle = I2C_DUTYCYCLE_2;
  hi2c2.Init.OwnAddress1 = 0;
  hi2c2.Init.AddressingMode = I2C_ADDRESSINGMODE_7BIT;
  hi2c2.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
  hi2c2.Init.OwnAddress2 = 0;
  hi2c2.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
  hi2c2.Init.NoStretchMode = I2C_NOSTRETCH_DISABLE;
  if (HAL_I2C_Init(&hi2c2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN I2C2_Init 2 */

  /* USER CODE END I2C2_Init 2 */

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

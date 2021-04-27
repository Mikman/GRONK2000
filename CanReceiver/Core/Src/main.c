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
#include "circle_queue.h"
#include "stdio.h"
#include "string.h"
#include "circle_queue_struct.h"
#include "stdbool.h"
#include "can_driver.h"
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

#define PACKAGE_SIZE 8
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
CAN_HandleTypeDef hcan1;

UART_HandleTypeDef huart2;

/* USER CODE BEGIN PV */
/* USER CODE BEGIN PV */

CAN_FilterTypeDef CanFilter;
CAN_RxHeaderTypeDef CanRxHeader;
CAN_TxHeaderTypeDef CanTxHeader;

//GPS DATA ID'S
uint32_t GPS_ID1 = 0x1;
uint32_t GPS_ID2 = 0x2;
uint32_t GPS_ID3 = 0x3;
uint32_t GPS_ID4 = 0x4;

//MPU DATA ID'S
uint32_t MPU_ID5 = 0X5;
uint32_t MPU_ID6 = 0X6;
uint32_t MPU_ID7 = 0X7;
uint32_t MPU_ID8 = 0X8;

//MOTOR DATA ID
uint32_t MOTOR_ID9 = 0X9;

//WATCHDOG DATA ID
uint32_t WATCHDOG_ID10 = 0X0A;

//uint32_t ACCELID = 0x5;
//uint32_t DCMOTORID = 0x7;

// Recieved GPS data from CubeSAT
float GPS_LAT = 0.;
char GPS_LAT_DIR = '$';
float GPS_LON = 0.;
char GPS_LON_DIR = '$';
uint8_t GPS_QUALITY = 0;
uint8_t GPS_HOURS = 0;
uint8_t GPS_MINUTES = 0;
uint8_t GPS_SEC = 0;
float GPS_HDOP = 0.;
float GPS_ALTITUDE = 0.;
float GPS_H_GEOID = 0.;

//Recieved MPU data from CubeSAT
float MPU_ACCELX = 0.;
float MPU_ACCELY = 0.;
float MPU_ACCELZ = 0.;
float MPU_GYROX = 0.;
float MPU_GYROY = 0.;
float MPU_GYROZ = 0.;
float MPU_TEMP = 0.;

//Recieved MOTOR data from CubeSAT
uint8_t MOTOR_DUTYCYCLE = 0;

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_USART2_UART_Init(void);
static void MX_CAN1_Init(void);
/* USER CODE BEGIN PFP */

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
  MX_USART2_UART_Init();
  MX_CAN1_Init();
  /* USER CODE BEGIN 2 */
  can_init(&hcan1, &CanRxHeader, &CanTxHeader, &huart2);
 // HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_SET);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  uint8_t sendDataArray[PACKAGE_SIZE] = {1, 2, 4, 8, 16, 32, 64, 128};

  while (1)
  {
	 if(HAL_GPIO_ReadPin(GPIOB, GPIO_PIN_6)){
		 //transmitData(&GPSDATA);
		 HAL_Delay(200);
		 sendData(&hcan1, 0x5, PACKAGE_SIZE, sendDataArray, &CanTxHeader);
		 //sendMOTOR();

	 }


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
  RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

  /** Configure LSE Drive Capability
  */
  HAL_PWR_EnableBkUpAccess();
  __HAL_RCC_LSEDRIVE_CONFIG(RCC_LSEDRIVE_LOW);
  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_LSE|RCC_OSCILLATORTYPE_MSI;
  RCC_OscInitStruct.LSEState = RCC_LSE_ON;
  RCC_OscInitStruct.MSIState = RCC_MSI_ON;
  RCC_OscInitStruct.MSICalibrationValue = 0;
  RCC_OscInitStruct.MSIClockRange = RCC_MSIRANGE_6;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_MSI;
  RCC_OscInitStruct.PLL.PLLM = 1;
  RCC_OscInitStruct.PLL.PLLN = 36;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV7;
  RCC_OscInitStruct.PLL.PLLQ = RCC_PLLQ_DIV2;
  RCC_OscInitStruct.PLL.PLLR = RCC_PLLR_DIV2;
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
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_4) != HAL_OK)
  {
    Error_Handler();
  }
  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_USART2;
  PeriphClkInit.Usart2ClockSelection = RCC_USART2CLKSOURCE_PCLK1;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
  {
    Error_Handler();
  }
  /** Configure the main internal regulator output voltage
  */
  if (HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1) != HAL_OK)
  {
    Error_Handler();
  }
  /** Enable MSI Auto calibration
  */
  HAL_RCCEx_EnableMSIPLLMode();
}

/**
  * @brief CAN1 Initialization Function
  * @param None
  * @retval None
  */
static void MX_CAN1_Init(void)
{

  /* USER CODE BEGIN CAN1_Init 0 */
	  uint32_t ext_id = 0x00000000;							// Den største værdi der kan være på MSB er 1
	  uint32_t mask = 0xFFFFFFE0;
	  CanFilter.FilterMode = CAN_FILTERMODE_IDMASK;			// Vi vælger at bruge mask mode
	  CanFilter.FilterIdHigh = (ext_id & 0x1FFFFFFF) >> 13; // (ext_id << 3) >> 16;						// Da vi har 32 bit ID, er dette de 16 MSB af ID
	  CanFilter.FilterIdLow =  (ext_id << 3) | CAN_ID_EXT;	// Da vi har 32 bit ID, er dette de 16 LSB af ID
	  CanFilter.FilterMaskIdHigh = (mask & 0x1FFFFFFF) >> 13;// << 5;					// Maskens 16 MSB
	  CanFilter.FilterMaskIdLow = (mask << 3);// << 5 | 0x10;					// Maskens 16 LSB
	  CanFilter.FilterScale = CAN_FILTERSCALE_32BIT;		// ID er et 32 bit-tal
	  CanFilter.FilterActivation = ENABLE;					// Vi aktiverer filteret
	  CanFilter.FilterBank = 0;								// Vi vælger filter 0 ud af 14 mulige filtre
	  CanFilter.FilterFIFOAssignment = CAN_FILTER_FIFO0;	// Vi vælger FIFO0 til forskel for FIFO1


	  CanRxHeader.DLC = PACKAGE_SIZE;
	  CanRxHeader.ExtId = 0x0;
	  CanRxHeader.IDE = CAN_ID_EXT;
	  CanRxHeader.RTR = CAN_RTR_DATA;
	  CanRxHeader.FilterMatchIndex = 0x00;

	  CanTxHeader.DLC = PACKAGE_SIZE;                        // Der kommer 8 byte som data i beskeden
	  CanTxHeader.ExtId = 0x00000000;                        // 32 bit ID (29 er identifier)
	  CanTxHeader.IDE = CAN_ID_EXT;                            // Vi har et extended ID = 32 bit til forskel fra standard på 16 bit (11 er identifier)
	  CanTxHeader.RTR = CAN_RTR_DATA;                        // Vi sender data
	  CanTxHeader.TransmitGlobalTime = DISABLE;                // Der skal IKKE sendes et timestamp med hver besked

  /* USER CODE END CAN1_Init 0 */

  /* USER CODE BEGIN CAN1_Init 1 */
	  __HAL_RCC_CAN1_CLK_ENABLE();

  /* USER CODE END CAN1_Init 1 */
  hcan1.Instance = CAN1;
  hcan1.Init.Prescaler = 18;
  hcan1.Init.Mode = CAN_MODE_NORMAL;
  hcan1.Init.SyncJumpWidth = CAN_SJW_1TQ;
  hcan1.Init.TimeSeg1 = CAN_BS1_7TQ;
  hcan1.Init.TimeSeg2 = CAN_BS2_8TQ;
  hcan1.Init.TimeTriggeredMode = DISABLE;
  hcan1.Init.AutoBusOff = DISABLE;
  hcan1.Init.AutoWakeUp = DISABLE;
  hcan1.Init.AutoRetransmission = ENABLE;
  hcan1.Init.ReceiveFifoLocked = DISABLE;
  hcan1.Init.TransmitFifoPriority = ENABLE;
  if (HAL_CAN_Init(&hcan1) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN CAN1_Init 2 */

    while (HAL_CAN_ConfigFilter(&hcan1, &CanFilter) != HAL_OK) {}
    HAL_CAN_ActivateNotification(&hcan1, CAN_IT_RX_FIFO0_MSG_PENDING);
    HAL_CAN_Start(&hcan1);
  /* USER CODE END CAN1_Init 2 */

}

/**
  * @brief USART2 Initialization Function
  * @param None
  * @retval None
  */
static void MX_USART2_UART_Init(void)
{

  /* USER CODE BEGIN USART2_Init 0 */

  /* USER CODE END USART2_Init 0 */

  /* USER CODE BEGIN USART2_Init 1 */

  /* USER CODE END USART2_Init 1 */
  huart2.Instance = USART2;
  huart2.Init.BaudRate = 115200;
  huart2.Init.WordLength = UART_WORDLENGTH_8B;
  huart2.Init.StopBits = UART_STOPBITS_1;
  huart2.Init.Parity = UART_PARITY_NONE;
  huart2.Init.Mode = UART_MODE_TX_RX;
  huart2.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart2.Init.OverSampling = UART_OVERSAMPLING_16;
  huart2.Init.OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE;
  huart2.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
  if (HAL_UART_Init(&huart2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART2_Init 2 */

  /* USER CODE END USART2_Init 2 */

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_0|LD3_Pin|GPIO_PIN_7, GPIO_PIN_RESET);

  /*Configure GPIO pin : PA6 */
  GPIO_InitStruct.Pin = GPIO_PIN_6;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLDOWN;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pins : PB0 LD3_Pin PB7 */
  GPIO_InitStruct.Pin = GPIO_PIN_0|LD3_Pin|GPIO_PIN_7;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

  /*Configure GPIO pin : PB6 */
  GPIO_InitStruct.Pin = GPIO_PIN_6;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLDOWN;
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

void sendMOTOR(){
	char str[5] = {0};
	// MOTOR
	sprintf(str, "%s", "Motor duty cycle: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%d", MOTOR_DUTYCYCLE);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
}

void sendMPU() {
	char str[15] = {0};

	// ACCCEL
	sprintf(str, "%s", "Accel_X: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_ACCELX);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "Accel_Y: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_ACCELY);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "Accel_Z: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_ACCELZ);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);

	// GYRO
	sprintf(str, "%s", "Gyro_X: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_GYROX);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "Gyro_Y: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_GYROY);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "Gyro_Z: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_GYROZ);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);

	//TEMP
	sprintf(str, "%s", "Temperature: " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", MPU_TEMP);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return

}

void sendGPS(){

	char str[15] = {0};
	sprintf(str, "%s", "Coordinates: " );					//Header
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%c", GPS_LAT_DIR);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", GPS_LAT);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%s", " , " );
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%c", GPS_LON_DIR);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", GPS_LON);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return

	sprintf(str, "%s", "Quality: ");						//Header
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%u", GPS_QUALITY);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "Time: ");							//Header
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%u", GPS_HOURS);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, ":", 2, 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%u", GPS_MINUTES);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, ":", 2, 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%u", GPS_SEC);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "Altitude: " );						//Header
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", GPS_ALTITUDE);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "HDOP: " );							//Header
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", GPS_HDOP);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return
	memset(str, 0, sizeof str);
	sprintf(str, "%s", "H_Geoid: " );						//Header
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	memset(str, 0, sizeof str);
	sprintf(str, "%f", GPS_H_GEOID);
	HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	HAL_UART_Transmit(&huart2, "\n", 2, 100);				//Newline
	HAL_UART_Transmit(&huart2, "\r", 2, 100);				//Carriage return

}


/*
void placeData(uint8_t *DataPass) {
	if (CanRxHeader.ExtId == 0x03)
	{
		for(int i = 0; i < PACKAGE_SIZE;i++) {
			if (!QueueFull(&GPSDATA)) {
				EnterQueue(&GPSDATA, *(DataPass + i));
			}

		}
	}
	if (CanRxHeader.ExtId == ACCELID) {
		for(int i = 0; i < PACKAGE_SIZE;i++) {
			if (!QueueFull(&ACCEL)) {
				EnterQueue(&ACCEL, *(DataPass + i));
			}
		}
	}
	if (CanRxHeader.ExtId == DCMOTORID) {
		for(int i = 0; i < PACKAGE_SIZE;i++) {
			if (!QueueFull(&DCMOTOR)) {
				EnterQueue(&DCMOTOR, *(DataPass + i));
			}
		}
	}

}
*/

void transmitData(struct Queue *Data)
{
	int writePointer = Data -> pointWR;
	int readPointer = Data -> pointRD;
	char str[3] = {0};
	uint8_t tempo = 0;
	int bytesToRead = writePointer - readPointer;
	for (int i = 0 ; i < bytesToRead ; i++){
		if ((i % 255) == 0) HAL_UART_Transmit(&huart2, "___", 3, 100);
		LeaveQueue(Data, &tempo);
		sprintf(str, "%d", tempo);
		HAL_UART_Transmit(&huart2, &str, strlen(str), 100);
	}
}
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

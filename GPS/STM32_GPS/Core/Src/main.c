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

#include "stdio.h"
#include "string.h"
#include <stdlib.h>

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

typedef struct {
	uint8_t HOURS;
	uint8_t MIN;
	uint8_t SEC;
	float LAT;
	char LAT_DIR;
	float LON;
	char LON_DIR;
	uint8_t QUALITY;
	uint8_t SATS;
	float HDOP;
	float ALTITUDE;
	float H_GEOID;
} GPS_FIX_DATA;

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

#define GPS_BUFSIZE 512
#define GPS_DATASIZE 100

#define GPS_SECTIONS 15
#define GPS_SEC_LENGTH 15

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
UART_HandleTypeDef huart1;

/* USER CODE BEGIN PV */

	char GPSFormat[6] = "$GPGGA";

	uint8_t rawData[GPS_BUFSIZE] = {0};
	uint8_t GPSData[GPS_BUFSIZE] = {0};



/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_USART1_UART_Init(void);
/* USER CODE BEGIN PFP */



int8_t readGPS(GPS_FIX_DATA *data){

	int flag = 0;
	HAL_UART_Receive(&huart1, rawData , GPS_BUFSIZE, HAL_MAX_DELAY); // Reads incoming UART transmission and blocks the CPU until 255 bytes is received.

	for (uint16_t i = 0 ; i < GPS_BUFSIZE && flag != 1 ; i = i + 1){ // Looking for start of data format indicated as '$'
		if (rawData[i] == '$') {
			char formatTest[6] = { 0 }; // String for format comparison, i.e. $GPGGA
			int check = 5; // Something else than 0 just for safety, since 0 means correct match

			for (uint8_t x = 0; x < 6; x = x + 1) {  // Loops over the next 6 characters and puts then in an array to check for the desired format
				formatTest[x] = rawData[i + x];
				check = strcmp(formatTest, GPSFormat);

				if (check == 0) {

					uint8_t counter = 0;
					for (i = i + 1; i < GPS_BUFSIZE; i = i + 1) { // loops until a '$' is found.
						if (rawData[i] != '$') {
							GPSData[counter] = rawData[i]; // Desired data format (GPGGA) is passed into another array
							counter = counter + 1;
						} else {
							flag = 1;
							break;
						}
					}
				}
			}
		}
	}

	if (flag != 1) {

		return 0; // No data available / Invalid data

	} else {

		uint8_t cksum_received = 0; // Check sum of received data

		for (uint16_t i = 0; i < GPS_DATASIZE; i++) {
			if (GPSData[i] == '*') break;
			cksum_received ^= GPSData[i];
		}

		// Divide GPSData string up in individual sections, each one in its own array sections[i]
		uint8_t sectionNum = 0, sectionChar = 0;

		char sections[GPS_SECTIONS][GPS_SEC_LENGTH] = { 0 };

		for (uint16_t i = 0; i < GPS_DATASIZE; i++) {

			if (GPSData[i] == ',') {
				sectionNum++;
				sectionChar = 0;
			}
			else {
				sections[sectionNum][sectionChar] = GPSData[i];
				sectionChar++;
			}
		}

		// Convert gps data from sections[i] into GPS_FIX_DATA struct

		char h[3] = {0}, m[3] = {0}, s[3] = {0};

		strncpy(h, sections[1], 2);
		strncpy(m, sections[1] + 2, 2);
		strncpy(s, sections[1] + 4, 2);

		data->HOURS = 	atoi(h);
		data->MIN = 	atoi(m);
		data->SEC = 	atoi(s);

		data->LAT = 	atof(sections[2]);
		data->LAT_DIR = sections[3][0];
		data->LON = 	atof(sections[4]);
		data->LON_DIR =	sections[5][0];
		data->QUALITY = atoi(sections[6]);
		data->SATS = 	atoi(sections[7]);
		data->HDOP = 	atof(sections[8]);
		data->ALTITUDE=	atof(sections[9]);
		data->H_GEOID =	atof(sections[11]);

		char ck[3] = { sections[14][1], sections[14][2], 0};

		char *eptr;
		uint8_t cksum_sent	=	strtol(ck, &eptr, 16);

		if (cksum_sent == cksum_received) return 1;
		else return -1;
	}
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
  MX_USART1_UART_Init();
  /* USER CODE BEGIN 2 */



  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
	 GPS_FIX_DATA data = { 0 };

	 int8_t result = readGPS(&data);

	 HAL_Delay(1000);



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
  * @brief USART1 Initialization Function
  * @param None
  * @retval None
  */
static void MX_USART1_UART_Init(void)
{

  /* USER CODE BEGIN USART1_Init 0 */

  /* USER CODE END USART1_Init 0 */

  /* USER CODE BEGIN USART1_Init 1 */

  /* USER CODE END USART1_Init 1 */
  huart1.Instance = USART1;
  huart1.Init.BaudRate = 9600;
  huart1.Init.WordLength = UART_WORDLENGTH_8B;
  huart1.Init.StopBits = UART_STOPBITS_1;
  huart1.Init.Parity = UART_PARITY_NONE;
  huart1.Init.Mode = UART_MODE_TX_RX;
  huart1.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart1.Init.OverSampling = UART_OVERSAMPLING_16;
  if (HAL_UART_Init(&huart1) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART1_Init 2 */

  /* USER CODE END USART1_Init 2 */

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

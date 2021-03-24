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
#include "parallel_ram.h"
#include "circle_queue.h"
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
CAN_HandleTypeDef hcan;

/* USER CODE BEGIN PV */
struct Queue queueRAM = {0, 0, {15, 15, 15, 15, 15, 15, 15, 15, 13, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 10, 10, 10, 0}};
struct Queue queueRx = {0, 0, {0}};

CAN_FilterTypeDef CanFilter;
CAN_TxHeaderTypeDef CanTxHeader;
CAN_RxHeaderTypeDef CanRxHeader;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_CAN_Init(void);
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
  MX_CAN_Init();
  HAL_CAN_Start(&hcan);

  /* USER CODE BEGIN 2 */

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */
	  sendImageData();
	  receiveImageData();
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
  * @brief CAN Initialization Function
  * @param None
  * @retval None
  */
static void MX_CAN_Init(void)
{

  /* USER CODE BEGIN CAN_Init 0 */

	  CanFilter.FilterIdHigh = 0x0000;						// Da vi har 32 bit ID, er dette de 16 MSB af ID
	  CanFilter.FilterIdLow = 0x0010;						// Da vi har 32 bit ID, er dette de 16 LSB af ID
	  CanFilter.FilterScale = CAN_FILTERSCALE_32BIT;		// ID er et 32 bit-tal
	  CanFilter.FilterActivation = ENABLE;					// Vi aktiverer filteret
	  CanFilter.FilterBank = 0;								// Vi vælger filter 0 ud af 14 mulige filtre
	  CanFilter.FilterFIFOAssignment = CAN_FILTER_FIFO0;	// Vi vælger FIFO0 til forskel for FIFO1


	  CanTxHeader.DLC = 8;									// Der kommer 1 byte som data i beskeden
	  CanTxHeader.ExtId = 0x00000010;						// 32 bit ID
	  CanTxHeader.IDE = CAN_ID_EXT;							// Vi har et extended ID = 32 bit til forskel fra standard på 16 bit
	  CanTxHeader.RTR = CAN_RTR_DATA;						// Vi sender data
	  CanTxHeader.TransmitGlobalTime = DISABLE;				// Der skal IKKE sendes et timestamp med hver besked


	  CanRxHeader.DLC = 8;
	  CanRxHeader.ExtId = 0x00000010;
	  CanRxHeader.IDE = CAN_ID_EXT;
	  CanRxHeader.RTR = CAN_RTR_DATA;

  /* USER CODE END CAN_Init 0 */

  /* USER CODE BEGIN CAN_Init 1 */

  /* USER CODE END CAN_Init 1 */
  hcan.Instance = CAN1;
  hcan.Init.Prescaler = 16;
  hcan.Init.Mode = CAN_MODE_LOOPBACK;
  hcan.Init.SyncJumpWidth = CAN_SJW_1TQ;
  hcan.Init.TimeSeg1 = CAN_BS1_8TQ;
  hcan.Init.TimeSeg2 = CAN_BS2_8TQ;
  hcan.Init.TimeTriggeredMode = DISABLE;
  hcan.Init.AutoBusOff = DISABLE;
  hcan.Init.AutoWakeUp = DISABLE;
  hcan.Init.AutoRetransmission = DISABLE;
  hcan.Init.ReceiveFifoLocked = DISABLE;
  hcan.Init.TransmitFifoPriority = ENABLE; // Denne er sat til enable, da transmissionen dermed sker som FIFO (til forskel fra "laveste mailbox først", som vi ikke har kontrol over)
  if (HAL_CAN_Init(&hcan) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN CAN_Init 2 */
  	  HAL_CAN_ConfigFilter(&hcan, &CanFilter);
  /* USER CODE END CAN_Init 2 */

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
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOC, GPIO_PIN_13, GPIO_PIN_RESET);

  /*Configure GPIO pin : PC13 */
  GPIO_InitStruct.Pin = GPIO_PIN_13;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

  /*Configure GPIO pins : PA0 PA1 PA2 PA3
                           PA4 PA5 PA6 PA7 */
  GPIO_InitStruct.Pin = GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3
                          |GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLDOWN;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pin : PB0 */
  GPIO_InitStruct.Pin = GPIO_PIN_0;
  GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
  GPIO_InitStruct.Pull = GPIO_PULLDOWN;
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

  /* EXTI interrupt init*/
  HAL_NVIC_SetPriority(EXTI0_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(EXTI0_IRQn);

}

/* USER CODE BEGIN 4 */

void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
	if(GPIO_Pin == GPIO_PIN_0){

		//Kode der implementerer en cirkel buffer
		EnterQueue(&queueRAM, (uint8_t) GPIOA->IDR &0xFF); // Sætter dataen på PA0-7 ind i køen.
	}
}


/*
void sendImageData() {
	uint8_t dataFromQueue[1] = {0};
	if (HAL_CAN_IsTxMessagePending(&hcan, (CAN_TX_MAILBOX0 | CAN_TX_MAILBOX1 | CAN_TX_MAILBOX2)) == 0) { // Hvis der ikke allerede er en byte i mailbox'en
		if (LeaveQueue(&queueRAM, &dataFromQueue)) { // Hvis den cirkulære buffer ikke er tom, fjern en byte
			HAL_CAN_AddTxMessage(&hcan, &CanTxHeader, dataFromQueue, NULL); // Send en byte over CAN
		}
	}
}
*/

void sendImageData() {
	uint8_t dataToMB0[8] = {0};
	uint8_t dataToMB1[8] = {0};
	uint8_t dataToMB2[8] = {0};

	if (HAL_CAN_IsTxMessagePending(&hcan, (CAN_TX_MAILBOX0 | CAN_TX_MAILBOX1 | CAN_TX_MAILBOX2)) == 0) {
		if (fillDataArray(&queueRAM, &dataToMB0)) {
			HAL_CAN_AddTxMessage(&hcan, &CanTxHeader, dataToMB0, NULL);
		}
		if (fillDataArray(&queueRAM, &dataToMB1)) {
					HAL_CAN_AddTxMessage(&hcan, &CanTxHeader, dataToMB1, NULL);
		}
		if (fillDataArray(&queueRAM, &dataToMB2)) {
					HAL_CAN_AddTxMessage(&hcan, &CanTxHeader, dataToMB2, NULL);
		}
	}
}

void fillDataArray(struct Queue source, uint8_t data[]) {
	for (int i = 0; i < 8; i++) {
		if (LeaveQueue(source, data[i])) {
			continue;
		} else {
			return 0;
		}
	}
	return 1;
}

void receiveImageData() {
	uint8_t buffer[8] = {0};
	if (!QueueFull(&queueRx)) { // Hvis køen ikke er fuld - Hvis der er en plads til at modtage en besked
		HAL_CAN_GetRxMessage(&hcan, CAN_RX_FIFO0, &CanRxHeader, buffer); // Modtag beskeden og læg den i buffer
		EnterQueue(&queueRx, buffer[0]); // Læg buffer ind i modtager-queuen
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

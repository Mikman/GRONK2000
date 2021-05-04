/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32l4xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

void HAL_TIM_MspPostInit(TIM_HandleTypeDef *htim);

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define Watchdog_out_Pin GPIO_PIN_14
#define Watchdog_out_GPIO_Port GPIOC
#define DC_motor_Dir1_Pin GPIO_PIN_15
#define DC_motor_Dir1_GPIO_Port GPIOC
#define LSB0_Pin GPIO_PIN_0
#define LSB0_GPIO_Port GPIOA
#define LSB1_Pin GPIO_PIN_1
#define LSB1_GPIO_Port GPIOA
#define LSB2_Pin GPIO_PIN_2
#define LSB2_GPIO_Port GPIOA
#define LSB3_Pin GPIO_PIN_3
#define LSB3_GPIO_Port GPIOA
#define MSB0_Pin GPIO_PIN_4
#define MSB0_GPIO_Port GPIOA
#define MSB1_Pin GPIO_PIN_5
#define MSB1_GPIO_Port GPIOA
#define MSB2_Pin GPIO_PIN_6
#define MSB2_GPIO_Port GPIOA
#define MSB3_Pin GPIO_PIN_7
#define MSB3_GPIO_Port GPIOA
#define Address_inc_Pin GPIO_PIN_0
#define Address_inc_GPIO_Port GPIOB
#define Get_image_pin_Pin GPIO_PIN_1
#define Get_image_pin_GPIO_Port GPIOB
#define PWM_CAM_Pin GPIO_PIN_8
#define PWM_CAM_GPIO_Port GPIOA
#define SWDIO_Pin GPIO_PIN_13
#define SWDIO_GPIO_Port GPIOA
#define SWCLK_Pin GPIO_PIN_14
#define SWCLK_GPIO_Port GPIOA
#define DC_motor_Dir2_Pin GPIO_PIN_4
#define DC_motor_Dir2_GPIO_Port GPIOB
#define Transfer_pin_Pin GPIO_PIN_5
#define Transfer_pin_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

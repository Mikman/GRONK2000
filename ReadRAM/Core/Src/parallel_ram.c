/*
 * parallel_ram.c
 *
 *  Created on: Mar 15, 2021
 *      Author: Mikkel
 */
#include "parallel_ram.h"

unsigned int ReadRamData() {
	return GPIOA->IDR & 0xFF; //Læser de første 8 bits data.
}

void ReadRam_Init() {

}

void LoadData_Callback() {
	HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_13);
}

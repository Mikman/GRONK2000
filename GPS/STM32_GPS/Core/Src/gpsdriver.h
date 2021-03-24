/*
 * gpsdriver.h
 *
 *  Created on: 24. mar. 2021
 *      Author: Mikkel
 */

#ifndef SRC_GPSDRIVER_H_
#define SRC_GPSDRIVER_H_

#include "stdio.h"
#include "string.h"
#include <stdlib.h>
#include "stm32f1xx_hal.h"

#define GPS_BUFSIZE 512
#define GPS_DATASIZE 100

#define GPS_SECTIONS 15
#define GPS_SEC_LENGTH 15

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

int8_t readGPS(UART_HandleTypeDef *uart, GPS_FIX_DATA *data);
int8_t convertToString(GPS_FIX_DATA *data, char *str);

#endif /* SRC_GPSDRIVER_H_ */

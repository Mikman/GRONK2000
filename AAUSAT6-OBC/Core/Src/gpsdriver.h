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
#include "stm32l4xx_hal.h"
#include "circle_queue_struct.h"
#include "can_driver.h"

#define GPS_BUFSIZE 512		// Receive buffer size for incoming GPS UART data
#define GPS_DATASIZE 83		// Buffer size for received GPGGA string

#define GPS_SECTIONS 15		// Amount of comma-separated fields in the received GPGGA string
#define GPS_SEC_LENGTH 15	// The length of each comma-separated field

#define GPS_ID_CTRL 8

/**
 * Data struct for holding data for a single GPS Fix
 */
typedef struct {
	uint8_t HOURS;
	uint8_t MIN;
	uint8_t SEC;
	float LAT; 		// DDMM.mmmm
	char LAT_DIR;
	float LON; 		// DDDMM.mmmm
	char LON_DIR;
	uint8_t QUALITY;
	uint8_t SATS;
	float HDOP;
	float ALTITUDE;
	float H_GEOID;
} GPS_FIX_DATA;

/**
 *
 */
void gps_init(UART_HandleTypeDef *huart, DMA_Channel_TypeDef *dmac);

/**
 * Read GPGGA data (GPA-data) from the UART peripheral, and assign received data to the GPS_FIX_DATA pointer.
 * Function returns:
 *   1: Succesful data received
 *  -1: Error in transmission
 *   0: No valid data received
 */
int8_t readGPS(GPS_FIX_DATA *data);

int8_t convertToString(GPS_FIX_DATA *data, char *str);

void GPS();

#endif /* SRC_GPSDRIVER_H_ */

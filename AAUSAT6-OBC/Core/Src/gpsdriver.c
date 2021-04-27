/*
 * gpsdriver.c
 *
 *  Created on: 24. mar. 2021
 *      Author: Mikkel
 */


#include "gpsdriver.h"

char GPSFormat[7] = "$GPGGA";

UART_HandleTypeDef *uart;
DMA_Channel_TypeDef *dma;


uint32_t GPS_DATA_ID = 0x2;
struct CAN_QUEUE_DATA GPS_DATA = {0,{0}};
struct StructQueue GPS_CAN_RX_QUEUE = {0};
GPS_FIX_DATA data = { 0 };


uint8_t rawData[GPS_BUFSIZE] = {0};
uint8_t holdData[GPS_BUFSIZE] = {0};
uint8_t GPSData[GPS_DATASIZE] = {0};

void gps_init(UART_HandleTypeDef *huart, DMA_Channel_TypeDef *dmac) {
	uart = huart;
	dma = dmac;
}

int8_t readGPS(GPS_FIX_DATA *data){

	int flag = 0;

	HAL_UART_Receive_DMA(uart, rawData, GPS_BUFSIZE);

	for (uint16_t i = 0; i < GPS_BUFSIZE; i++) {
		holdData[i] = rawData[i];
	}

	uint16_t dmaCounter = dma->CNDTR;

	uint16_t index = GPS_BUFSIZE - dmaCounter;

	for (uint16_t i = 0 ; i < GPS_BUFSIZE && flag != 1 ; i = i + 1){ // Looking for start of data format indicated as '$'
		if (holdData[i] == '$') {
			char formatTest[7] = { 0 }; // String for format comparison, i.e. $GPGGA
			int check = 5; // Something else than 0 just for safety, since 0 means correct match

			for (uint8_t x = 0; x < 6; x = x + 1) {  // Loops over the next 6 characters and puts then in an array to check for the desired format
				formatTest[x] = holdData[i + x];
				check = strcmp(formatTest, GPSFormat);

				if (check == 0) {

					// This checks to see if the DMA was writing in the middle of the area we expect our message to be
					if (((index >= i) || (i >= GPS_BUFSIZE - GPS_DATASIZE)) && index < (i + GPS_DATASIZE) % GPS_BUFSIZE) {
						break;
					}

					uint8_t counter = 0;
					for (i = i + 1; i < GPS_BUFSIZE; i = i + 1) { // loops until a '$' is found.
						if (holdData[i] != '$') {
							GPSData[counter] = holdData[i]; // Desired data format (GPGGA) is passed into another array
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
		char ck[3] = { sections[14][1], sections[14][2], 0};

		char *eptr;
		uint8_t cksum_sent	=	strtol(ck, &eptr, 16);

		if (cksum_sent != cksum_received) return -1;

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
		return 1;
	}
}


int8_t convertToString(GPS_FIX_DATA *data, char *str) {
	return 0;
}


void GPS(){
	if(UnreadElements(&GPS_CAN_RX_QUEUE)){

		readGPS(&data);
		LeaveStructQueue(&GPS_CAN_RX_QUEUE, &GPS_DATA);

		//TODO: sort rx data and gather what's requested
		// Der er allerede nogle funktioner i Transmit_driver.c

		passToCanTX(&GPS_DATA);

	}else{

		return;
	}
}

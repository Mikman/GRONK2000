/*
 * gpsdriver.c
 *
 *  Created on: 24. mar. 2021
 *      Author: Mikkel
 */


#include "gpsdriver.h"

char GPSFormat[6] = "$GPGGA";

uint8_t rawData[GPS_BUFSIZE] = {0};
uint8_t GPSData[GPS_BUFSIZE] = {0};

int8_t readGPS(UART_HandleTypeDef *uart, GPS_FIX_DATA *data){

	int flag = 0;
	HAL_UART_Receive(uart, rawData , GPS_BUFSIZE, HAL_MAX_DELAY); // Reads incoming UART transmission and blocks the CPU until 255 bytes is received.

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


int8_t convertToString(GPS_FIX_DATA *data, char *str) {
	return 0;
}

/*
 * comm_relay.c
 *
 *  Created on: 28. apr. 2021
 *      Author: Mikkel
 */

#include "comm_relay.h"

int to_frame(char * frame, size_t frame_size, struct CAN_QUEUE_DATA * package) {
	if (frame_size < COMM_MAX_FRAME_SIZE + 1) return -1;

	int i = 1, j = 0;

	frame[0] = COMM_DEL_START;

	for (; i < frame_size && j < PACKAGE_SIZE + 1; i++, j++) {
		char c;
		if (j == 0) c = package->ID;
		else c = package->data[j-1];

		if (is_special_character(c)) {
			frame[i] = COMM_ESCAPE;
			frame[i+1] = c + 2;
			i++;
		} else {
			frame[i] = c;
		}
	}

	frame[i] = COMM_DEL_STOP;

	return 1;
}

int is_special_character(char c) {
	if ((c == COMM_DEL_START) || (c == COMM_DEL_STOP) || (c == COMM_ESCAPE)) return 1;
	return 0;
}

int from_frame(const char * frame, struct CAN_QUEUE_DATA * package) {
	int len = strlen(frame);
	int i = 0, j = 0;

	if (frame[0] == COMM_DEL_START) i++;

	for (; i < len && j < PACKAGE_SIZE + 1; i++, j++) {
		char c = 0;

		if (frame[i] == COMM_DEL_START || frame[i] == COMM_DEL_STOP) return -1; // If we meet start or stop delimiter inside frame data, something's wrong.

		if (frame[i] == COMM_ESCAPE) {
			c = frame[i+1] - 2; // Return the character after the escape character minus 2
			i++;
		}
		else c = frame[i]; // The was no escape character, so return it



		if (j == 0) package->ID = c; // If we are iterating the ID
		else package->data[j-1] = c; 	// If we are iterating the data
	}

	if (i < len) {
		if (!(frame[i] == COMM_DEL_STOP || frame[i] == 0)) return -1;
	}
	return 1;
}

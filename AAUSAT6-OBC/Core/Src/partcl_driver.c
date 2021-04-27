/*
 * partcl_driver.c
 *
 *  Created on: 20. apr. 2021
 *      Author: Mikkel
 */

#include "partcl_driver.h"

char input[BUF_SIZE_IN] = {0};

uint16_t i_read = 0;

struct CAN_QUEUE_DATA PARTCL_DATA = {0,{0}};
struct StructQueue PARTCL_CAN_RX_QUEUE = {0};

void partcl_init() {
	struct CAN_QUEUE_DATA testData = {CAN_ID_PARTCL_INPUT,"tF 1; se"};
	EnterStructQueue(&PARTCL_CAN_RX_QUEUE, &testData);
	struct CAN_QUEUE_DATA testData2 = {CAN_ID_PARTCL_INPUT,"tPWM 55;"};
	EnterStructQueue(&PARTCL_CAN_RX_QUEUE, &testData2);
	tcl_setup();
}

void partcl_readQueue() {
	while (UnreadElements(&PARTCL_CAN_RX_QUEUE)) {
		LeaveStructQueue(&PARTCL_CAN_RX_QUEUE, &PARTCL_DATA); // Read a package from queue

		// Run through all accepted CAN packages
		switch (PARTCL_DATA.ID) {
		case CAN_ID_PARTCL_INPUT:
			strncat(input, (char *) &(PARTCL_DATA.data), 8); // Copy 8 characters or less (if null) from package into input buffer
			break;
		default:
			continue; // Skip package if it is not with an expected ID
		}
	}
}

void partcl_execute() {
	partcl_readQueue(); // Read input message from queue

	if (*input != 0) tcl_execute(); // Interpret and execute input progam
	else return;

	memset(input, 0, BUF_SIZE_IN); // Clear input buffer
}

char partcl_getInputChar() {
	// Go to start of input buffer if end of buffer is reached
	if (i_read >= BUF_SIZE_IN) {
		i_read = 0;
		return 0;
	}

	char inp = input[i_read++];
	if (inp == 0) i_read = 0; // Go to start of input buffer if a 0 (null character) is read
	return inp;
}

void partcl_printf(const char *str) {
	int len = strlen(str);
	for (int i = 0; i < len; i+=8) {
		struct CAN_QUEUE_DATA package = {0,{0}}; // Initialize CAN package
		package.ID = CAN_ID_PARTCL_OUTPUT; // Set partcl output can id

		strncpy((char *) &(package.data), (str + i), PACKAGE_SIZE); // Copy up to PACKAGE_SIZE (8) characters from string, excluding the ones already passed/sent.


		while (/*!passToCanTX(&package)*/0) { taskYIELD(); } // Wait until there is space in the queue
	}
}

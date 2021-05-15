/*
 * partcl_driver.c
 *
 *  Created on: 20. apr. 2021
 *      Author: Mikkel
 */

#include "partcl_driver.h"

char input[BUF_SIZE_IN] = {0};

uint16_t i_read = 0;
enum PARTCL_STATUS STATUS;

struct CAN_QUEUE_DATA PARTCL_DATA = {0,{0}};
struct StructQueue PARTCL_CAN_RX_QUEUE = {0};

void partcl_readQueue() {

	while (UnreadElements(&PARTCL_CAN_RX_QUEUE)) {
		LeaveStructQueue(&PARTCL_CAN_RX_QUEUE, &PARTCL_DATA); // Read a package from queue

		// Run through all accepted CAN packages
		switch (PARTCL_DATA.ID) {
		case CAN_ID_PARTCL_INPUT:
			if (STATUS == PARTCL_RECEIVING)
				partcl_add_program((char *) &(PARTCL_DATA.data), 8); // Copy 8 characters or less (if null) from package into input buffer
			else
			{
				partcl_printf("ERR: Send control package before program package.");
			}
			break;

		case CAN_ID_PARTCL_CONTROL:
			if(PARTCL_DATA.data[0] > 0 && PARTCL_DATA.data[1] == 0) {
				//Start pakke kommer nu ?!
				STATUS = PARTCL_RECEIVING;

				tcl_suspend();

				partcl_printf("Start.");
				memset(input, 0, BUF_SIZE_IN); // Clear input buffer

			}
			else if(PARTCL_DATA.data[1] > 0 && PARTCL_DATA.data[0] == 0) {
				//Slutning af pakken er nu kommet
				partcl_printf("Slut.");
				STATUS = PARTCL_READY;
			}
			else {
				partcl_printf("Invalid command package.");
			}
			break;

		default:
			continue; // Skip package if it is not with an expected ID
		}
	}
}

void partcl_execute() {

	if (STATUS == PARTCL_READY && *input != 0) {
		tcl_resume();
		tcl_execute(); // Interpret and execute input progam
	}
}

void partcl_add_program(char * str, size_t size) {
	strncat(input, str, size);
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


		while (!passToCanTX(&package)) { taskYIELD(); } // Wait until there is space in the queue
	}
}

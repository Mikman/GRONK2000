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

#define TASK_QUEUE_LENGTH_PARTCL 2
struct CAN_QUEUE_DATA taskQueueParTcl[TASK_QUEUE_LENGTH_PARTCL] = {0};

struct CAN_QUEUE_DATA PARTCL_DATA = {0,{0}};
struct StructQueue PARTCL_CAN_RX_QUEUE = {.pointRD = 0, .pointWR = 0, .queueLength = TASK_QUEUE_LENGTH_PARTCL, .queue = taskQueueParTcl};

extern uint32_t timerCounter;

#define TIMESTAMPS_LEN 100
uint16_t i = 0;
uint16_t timeStamps[TIMESTAMPS_LEN] = { 0 };
uint32_t timeStampsCounter[TIMESTAMPS_LEN] = {0};

int16_t elementsInQueue[TIMESTAMPS_LEN] = { 0 };

void partcl_readQueue() {

	while (UnreadElements(&PARTCL_CAN_RX_QUEUE)) {
		uint16_t elements = PARTCL_CAN_RX_QUEUE.pointWR - PARTCL_CAN_RX_QUEUE.pointRD;
		LeaveStructQueue(&PARTCL_CAN_RX_QUEUE, &PARTCL_DATA); // Read a package from queue


		if (i < TIMESTAMPS_LEN) {
			timeStamps[i] = TIM15->CNT;
			TIM15->CNT = 0;
			timeStampsCounter[i] = timerCounter;
			timerCounter = 0;
			elementsInQueue[i] = elements;
			if (i == 2) {
				int dev = -1;
			}
			i++;
		}



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

				partcl_printf("Program cleared.");
				memset(input, 0, BUF_SIZE_IN); // Clear input buffer

			}
			else if(PARTCL_DATA.data[1] > 0 && PARTCL_DATA.data[0] == 0) {
				//Slutning af pakken er nu kommet
				partcl_printf("Program running.");
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
		//hvis ("single" mode == true && !fullysuspended), så memset(input, 0, BUF_SIZE_IN), hvilket betyder at programdataen er slettet og at partcl ikke kører mere.
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
	if (*str == 0) return;
	char temp[256] = {0};
	strcpy(temp, str);
	char eot[2] = {PARTCL_EOT, 0};
	strncat(temp, eot, 1);

	int len = strlen(temp);
	for (int i = 0; i < len; i+=8) {
		struct CAN_QUEUE_DATA package = {0,{0}}; // Initialize CAN package
		package.ID = CAN_ID_PARTCL_OUTPUT; // Set partcl output can id

		strncpy((char *) &(package.data), (temp + i), PACKAGE_SIZE); // Copy up to PACKAGE_SIZE (8) characters from string, excluding the ones already passed/sent.


		while (!passToCanTX(&package)) {
			taskYIELD();
		} // Wait until there is space in the queue
	}
}

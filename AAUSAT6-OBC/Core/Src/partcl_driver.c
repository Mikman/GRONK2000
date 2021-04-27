/*
 * partcl_driver.c
 *
 *  Created on: 20. apr. 2021
 *      Author: Mikkel
 */

#include "partcl_driver.h"

char input[BUF_SIZE_IN] = "testFunc 100;";
char output[BUF_SIZE_OUT] = {0};

uint16_t i_read = 0;
uint16_t o_write = 0;

uint32_t PARTCL_DATA_ID = 0x4;
struct CAN_QUEUE_DATA PARTCL_DATA = {0,{0}};
struct StructQueue PARTCL_CAN_RX_QUEUE = {0};

void partcl_init() {
	tcl_setup();
}

void partcl_update() {
	tcl_loop();
}

char partcl_getInputChar() {
	if (i_read >= BUF_SIZE_IN) {
		i_read = 0;
		return 0;
	}

	char inp = input[i_read++];
	if (inp == 0) i_read = 0;
	return inp;
}

void partcl_printf(char *str) {
	if (o_write >= BUF_SIZE_OUT) {
		o_write = 0;
		memset(output, 0, sizeof output);
	}

	strcpy(output + o_write, str);
	o_write += strlen(str);
}

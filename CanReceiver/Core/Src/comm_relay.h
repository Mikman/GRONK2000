/*
 * comm_relay.h
 *
 *  Created on: 28. apr. 2021
 *      Author: Mikkel
 */

#ifndef SRC_COMM_RELAY_H_
#define SRC_COMM_RELAY_H_

#include "can_driver.h"
#include "string.h"

#define COMM_DEL_START '$'
#define COMM_DEL_STOP '@'
#define COMM_ESCAPE '#'

#define COMM_MAX_FRAME_SIZE 20

int to_frame(char * frame, size_t frame_size, struct CAN_QUEUE_DATA * package);

int is_special_character(char c);

const char * replace_escape(char c);

int from_frame(const char * frame, struct CAN_QUEUE_DATA * package);


#endif /* SRC_COMM_RELAY_H_ */

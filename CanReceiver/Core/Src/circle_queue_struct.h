/*
 * circle_queue.h
 *
 *  Created on: Mar 16, 2021
 *      Author: Mikkel
 */
#ifndef CIRCLE_STRUCT_QUEUE_H
#define CIRCLE_STRUCT_QUEUE_H

#include <stdint.h>

#define SIZE_OF_STRUCTQUEUE 160
#define PACKAGE_SIZE 8

struct CAN_QUEUE_DATA {
	uint32_t ID;
	uint8_t data[PACKAGE_SIZE];
};


struct StructQueue {
	uint16_t pointRD, pointWR;
	struct CAN_QUEUE_DATA queue[SIZE_OF_STRUCTQUEUE];
};


int StructQueueFull(struct StructQueue *q);
int StructQueueEmpty(struct StructQueue *q);
int EnterStructQueue(struct StructQueue *q, struct CAN_QUEUE_DATA *data);
int LeaveStructQueue(struct StructQueue *q, struct CAN_QUEUE_DATA *data);

#endif /* CIRCLE_STRUCT_QUEUE_H */

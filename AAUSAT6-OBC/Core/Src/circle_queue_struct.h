/*
 * circle_queue.h
 *
 *  Created on: Mar 16, 2021
 *      Author: Mikkel
 */

#ifndef SRC_CIRCLE_QUEUE_H_
#define SRC_CIRCLE_QUEUE_H_

#include <stdint.h>

#define SIZE_OF_STRUCTQUEUE 160
#define PACKAGE_SIZE 8

struct CAN_TX_DATA {
	uint32_t ID;
	uint8_t data[PACKAGE_SIZE];
};


struct StructQueue {
	uint16_t pointRD, pointWR;
	//struct CAN_TX_DATA queue[SIZE_OF_STRUCTQUEUE];
};
int StructQueueFull(struct StructQueue *q);
int StructQueueEmpty(struct StructQueue *q);
int EnterStructQueue(struct StructQueue *q, uint8_t data);
int LeaveStructQueue(struct StructQueue *q, uint8_t *data);


#endif /* SRC_CIRCLE_QUEUE_H_ */

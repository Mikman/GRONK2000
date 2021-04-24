/*
 * circle-queue.c
 *
 *  Created on: Mar 16, 2021
 *      Author: Mikkel
 */
#include "circle_queue.h"

int StructQueueFull(struct Queue *q){
	return (((q->pointWR +1) % SIZE_OF_QUEUE) == q->pointRD);
}

int StructQueueEmpty(struct Queue *q){
	return (q->pointWR == q->pointRD);
}

int EnterStructQueue(struct Queue *q, uint8_t data) {

	if (QueueFull(q)) {
		return 0;
	}
	else {
		q->queue[q->pointWR] = data;


		if ((q->pointWR + 1) == SIZE_OF_QUEUE){
			q->pointWR = 0;
		}
		else{
			q->pointWR += 1;
		}

	}
	return 1;
}

int LeaveStructQueue(struct Queue *q, uint8_t *data) {
	if (QueueEmpty(q)){
		return 0;
	}
	else {
		*data = q->queue[q->pointRD];
		if((q->pointRD + 1) ==SIZE_OF_QUEUE){
			q->pointRD = 0;
		}
		else{
			q->pointRD +=1;
		}
	}
	return 1;
}

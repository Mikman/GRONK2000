#include "can_driver.h"



CAN_TxHeaderTypeDef *TxHeader;
CAN_RxHeaderTypeDef *RxHeader;
CAN_HandleTypeDef *can1;

struct StructQueue CAN_TX_QUEUE = {0};
struct CAN_QUEUE_DATA CAN_TX_QUEUE_DATA = {0,{0}};


extern struct CAN_QUEUE_DATA MPU_DATA;
extern struct CAN_QUEUE_DATA GPS_DATA;
extern struct CAN_QUEUE_DATA MOTOR_DATA;
extern struct CAN_QUEUE_DATA PARTCL_DATA;
extern struct CAN_QUEUE_DATA IMAGE_DATA;

extern struct StructQueue MPU_CAN_RX_QUEUE;
extern struct StructQueue GPS_CAN_RX_QUEUE;
extern struct StructQueue MOTOR_CAN_RX_QUEUE;
extern struct StructQueue PARTCL_CAN_RX_QUEUE;
extern struct StructQueue IMAGE_CAN_RX_QUEUE;


bool CAN_Mailbox0Empty = true;
bool CAN_Mailbox1Empty = true;
bool CAN_Mailbox2Empty = true;


extern uint32_t MPU_DATA_ID;
extern uint32_t GPS_DATA_ID;
extern uint32_t MOTOR_DATA_ID;
extern uint32_t PARTCL_DATA_ID;
extern uint32_t IMAGE_DATA_ID;





void can_init(CAN_HandleTypeDef *hcan, CAN_RxHeaderTypeDef *CANRX, CAN_TxHeaderTypeDef *CANTX){
	TxHeader = CANTX;
	RxHeader = CANRX;
	can1 = hcan;
}


void HAL_CAN_TxMailbox0CompleteCallback(CAN_HandleTypeDef *hcan){
	if (CAN_TX_QUEUE.pointRD == CAN_TX_QUEUE.pointWR){
		CAN_Mailbox0Empty = true;
	}else {
		LeaveStructQueue(&CAN_TX_QUEUE, &CAN_TX_QUEUE_DATA);
		sendData(can1, CAN_TX_QUEUE_DATA.ID, PACKAGE_SIZE, CAN_TX_QUEUE_DATA.data, TxHeader);
	}
}

void HAL_CAN_TxMailbox1CompleteCallback(CAN_HandleTypeDef *hcan){
	if (CAN_TX_QUEUE.pointRD == CAN_TX_QUEUE.pointWR){
		CAN_Mailbox1Empty = true;
	}else {
		LeaveStructQueue(&CAN_TX_QUEUE, &CAN_TX_QUEUE_DATA);
		sendData(can1, CAN_TX_QUEUE_DATA.ID, PACKAGE_SIZE, CAN_TX_QUEUE_DATA.data, TxHeader);
	}
}
void HAL_CAN_TxMailbox2CompleteCallback(CAN_HandleTypeDef *hcan){
	if (CAN_TX_QUEUE.pointRD == CAN_TX_QUEUE.pointWR){
		CAN_Mailbox2Empty = true;
	}else {
		LeaveStructQueue(&CAN_TX_QUEUE, &CAN_TX_QUEUE_DATA);
		sendData(can1, CAN_TX_QUEUE_DATA.ID, PACKAGE_SIZE, CAN_TX_QUEUE_DATA.data, TxHeader);
	}
}


void receiveData() {
    uint8_t buffer[PACKAGE_SIZE] = {0};

    while (HAL_CAN_GetRxFifoFillLevel(can1, CAN_RX_FIFO0) > 0) {
         HAL_CAN_GetRxMessage(can1, CAN_RX_FIFO0, RxHeader, buffer); // Modtag beskeden og læg den i buffer
         placeData_1(buffer);
    }
}

void passToCanTX(struct CAN_QUEUE_DATA *data){
	if (CAN_Mailbox0Empty || CAN_Mailbox1Empty || CAN_Mailbox2Empty){
		sendData(can1, data->ID, PACKAGE_SIZE, data->data, TxHeader);
	}else {
		EnterStructQueue(&CAN_TX_QUEUE, data);
	}
}



void placeData_1(uint8_t *p){
	if(RxHeader->ExtId == MPU_DATA_ID){
		MPU_DATA.ID = RxHeader->ExtId;
		for (int i = 0 ; i < PACKAGE_SIZE ; i++){
			MPU_DATA.data[i] = p[i];
		}

		EnterStructQueue(&MPU_CAN_RX_QUEUE, &MPU_DATA);
	}
	else if(RxHeader->ExtId == GPS_DATA_ID){
			GPS_DATA.ID = RxHeader->ExtId;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				GPS_DATA.data[i] = p[i];
			}

			EnterStructQueue(&GPS_CAN_RX_QUEUE, &GPS_DATA);
		}
	else if(RxHeader->ExtId == MOTOR_DATA_ID){
			MOTOR_DATA.ID = RxHeader->ExtId;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				MOTOR_DATA.data[i] = p[i];
			}

			EnterStructQueue(&MOTOR_CAN_RX_QUEUE, &MOTOR_DATA);
		}
	else if(RxHeader->ExtId == PARTCL_DATA_ID){
			PARTCL_DATA.ID = RxHeader->ExtId;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				PARTCL_DATA.data[i] = p[i];
			}

			EnterStructQueue(&PARTCL_CAN_RX_QUEUE, &PARTCL_DATA);
		}
	else if(RxHeader->ExtId == IMAGE_DATA_ID){
			IMAGE_DATA.ID = RxHeader->ExtId;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				IMAGE_DATA.data[i] = p[i];
			}

			EnterStructQueue(&IMAGE_CAN_RX_QUEUE, &IMAGE_DATA);
		}
}

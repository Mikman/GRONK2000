#include "can_driver.h"



CAN_TxHeaderTypeDef *TxHeader;
CAN_RxHeaderTypeDef *RxHeader;
CAN_HandleTypeDef *can1;
#define CAN_TX_QUEUE_LENGTH 1000
struct CAN_QUEUE_DATA TXQueue[CAN_TX_QUEUE_LENGTH] = {0};
struct StructQueue CAN_TX_QUEUE = {.pointRD = 0, .pointWR = 0, .queue = TXQueue, .queueLength = CAN_TX_QUEUE_LENGTH};
struct CAN_QUEUE_DATA CAN_TX_QUEUE_DATA = {0,{0}};


extern struct CAN_QUEUE_DATA MPU_DATA_RX;
extern struct CAN_QUEUE_DATA MPU_DATA_TX;
extern struct CAN_QUEUE_DATA GPS_DATA_RX;
extern struct CAN_QUEUE_DATA GPS_DATA_TX;
extern struct CAN_QUEUE_DATA MOTOR_DATA_RX;
extern struct CAN_QUEUE_DATA MOTOR_DATA_TX;
extern struct CAN_QUEUE_DATA PARTCL_DATA;
extern struct CAN_QUEUE_DATA IMAGE_DATA_RX;
extern struct CAN_QUEUE_DATA IMAGE_DATA_TX;

extern struct StructQueue MPU_CAN_RX_QUEUE;
extern struct StructQueue GPS_CAN_RX_QUEUE;
extern struct StructQueue MOTOR_CAN_RX_QUEUE;
extern struct StructQueue PARTCL_CAN_RX_QUEUE;
extern struct StructQueue IMAGE_CAN_RX_QUEUE;


bool CAN_Mailbox0Empty = true;
bool CAN_Mailbox1Empty = true;
bool CAN_Mailbox2Empty = true;

extern int hvorErJeg;

void can_init(CAN_HandleTypeDef *hcan, CAN_RxHeaderTypeDef *CANRX, CAN_TxHeaderTypeDef *CANTX){
	TxHeader = CANTX;
	RxHeader = CANRX;
	can1 = hcan;
}

void HAL_CAN_TxMailbox0CompleteCallback(CAN_HandleTypeDef *hcan){
	SendFromInterrupt(hcan);
}

void HAL_CAN_TxMailbox1CompleteCallback(CAN_HandleTypeDef *hcan){
	SendFromInterrupt(hcan);
}

void HAL_CAN_TxMailbox2CompleteCallback(CAN_HandleTypeDef *hcan){
	SendFromInterrupt(hcan);
}

void SendFromInterrupt(CAN_HandleTypeDef *hcan) {
	if (UnreadElements(&CAN_TX_QUEUE)) {
		if (xSemaphoreTakeFromISR(semaphr_send, NULL) != pdPASS)
			return;

		if (!LeaveStructQueue(&CAN_TX_QUEUE, &CAN_TX_QUEUE_DATA)) return;

		if (!sendData(can1, CAN_TX_QUEUE_DATA.ID, PACKAGE_SIZE,
				CAN_TX_QUEUE_DATA.data, TxHeader, 2))
			Error_Handler();

		if (!xSemaphoreGiveFromISR(semaphr_send, NULL))
			Error_Handler();
	}
}


void receiveData() {
    uint8_t buffer[PACKAGE_SIZE] = {0};

    while (HAL_CAN_GetRxFifoFillLevel(can1, CAN_RX_FIFO0) > 0) {
         HAL_CAN_GetRxMessage(can1, CAN_RX_FIFO0, RxHeader, buffer); // Modtag beskeden og læg den i buffer
         placeData(RxHeader->ExtId, buffer);
    }
}

int passToCanTX(struct CAN_QUEUE_DATA *data){
	if (!sendData(can1, data->ID, PACKAGE_SIZE, data->data, TxHeader, 0))
		return EnterStructQueue(&CAN_TX_QUEUE, data);
}



void placeData(uint32_t id, uint8_t *p){
	if(id == MPU_ID_CTRL){
		CAN_TX_QUEUE_DATA.ID = id;
		for (int i = 0 ; i < PACKAGE_SIZE ; i++){
			CAN_TX_QUEUE_DATA.data[i] = p[i];
		}

		EnterStructQueue(&MPU_CAN_RX_QUEUE, &CAN_TX_QUEUE_DATA);
	}
	else if(id == GPS_ID_CTRL){
			CAN_TX_QUEUE_DATA.ID = id;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				CAN_TX_QUEUE_DATA.data[i] = p[i];
			}

			EnterStructQueue(&GPS_CAN_RX_QUEUE, &CAN_TX_QUEUE_DATA);
		}
	else if(id == MOTOR_ID_CTRL){
			CAN_TX_QUEUE_DATA.ID = id;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				CAN_TX_QUEUE_DATA.data[i] = p[i];
			}

			EnterStructQueue(&MOTOR_CAN_RX_QUEUE, &CAN_TX_QUEUE_DATA);
		}
	else if(id == CAN_ID_PARTCL_INPUT || id == CAN_ID_PARTCL_CONTROL){
			CAN_TX_QUEUE_DATA.ID = id;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				CAN_TX_QUEUE_DATA.data[i] = p[i];
			}

			EnterStructQueue(&PARTCL_CAN_RX_QUEUE, &CAN_TX_QUEUE_DATA);
		}
	else if(id == IMAGE_ID_CTRL){
			CAN_TX_QUEUE_DATA.ID = id;
			for (int i = 0 ; i < PACKAGE_SIZE ; i++){
				CAN_TX_QUEUE_DATA.data[i] = p[i];
			}

			EnterStructQueue(&IMAGE_CAN_RX_QUEUE, &CAN_TX_QUEUE_DATA);
		}
}

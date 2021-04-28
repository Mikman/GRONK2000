#include "can_driver.h"

CAN_TxHeaderTypeDef *TxHeader;
CAN_RxHeaderTypeDef *RxHeader;
CAN_HandleTypeDef *can1;

UART_HandleTypeDef *uart2;

struct StructQueue CAN_TX_QUEUE = {0};
struct StructQueue CAN_RX_QUEUE = {0};

struct CAN_QUEUE_DATA CAN_TX_QUEUE_DATA = {0,{0}};
struct CAN_QUEUE_DATA CAN_RX_QUEUE_DATA = {0,{0}};

bool CAN_Mailbox0Empty = true;
bool CAN_Mailbox1Empty = true;
bool CAN_Mailbox2Empty = true;

void can_init(CAN_HandleTypeDef *hcan, CAN_RxHeaderTypeDef *CANRX, CAN_TxHeaderTypeDef *CANTX, UART_HandleTypeDef *UART){
	TxHeader = CANTX;
	RxHeader = CANRX;
	can1 = hcan;
	uart2 = UART;
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


void CAN_handle_receive() {
    uint8_t buffer[PACKAGE_SIZE] = {0};

    while (HAL_CAN_GetRxFifoFillLevel(can1, CAN_RX_FIFO0) > 0) {
            HAL_CAN_GetRxMessage(can1, CAN_RX_FIFO0, RxHeader, buffer); // Modtag beskeden og læg den i buffer
            CAN_RX_QUEUE_DATA.ID = RxHeader->ExtId;
            for (int i = 0 ; 0 < PACKAGE_SIZE ; i++){
            	CAN_RX_QUEUE_DATA.data[i] = buffer[i];
            }
            EnterStructQueue(&CAN_RX_QUEUE, &CAN_RX_QUEUE_DATA);
        }
}

int CAN_from_queue(struct CAN_QUEUE_DATA * data) {
	return LeaveStructQueue(&CAN_RX_QUEUE, data);
}

void passToCanTX(struct CAN_QUEUE_DATA *data){
	if (CAN_Mailbox0Empty || CAN_Mailbox1Empty || CAN_Mailbox2Empty){
		sendData(can1, data->ID, PACKAGE_SIZE, data->data, TxHeader);
	}else {
		EnterStructQueue(&CAN_TX_QUEUE, data);
	}
}

#include "can_driver.h"

CAN_TxHeaderTypeDef *TxHeader;
CAN_RxHeaderTypeDef *RxHeader;
CAN_HandleTypeDef *can1;

UART_HandleTypeDef *uart2;

struct StructQueue CAN_TX_QUEUE = {0};
struct StructQueue CAN_RX_QUEUE = {0};

struct CAN_QUEUE_DATA CAN_TX_QUEUE_DATA = {0,{0}};
struct CAN_QUEUE_DATA CAN_RX_QUEUE_DATA = {0,{0}};

struct CAN_QUEUE_DATA MPU_DATA = {0,{0}};
struct CAN_QUEUE_DATA GPS_DATA = {0,{0}};
struct CAN_QUEUE_DATA MOTOR_DATA = {0,{0}};
struct CAN_QUEUE_DATA PARTCL_DATA = {0,{0}};
struct CAN_QUEUE_DATA IMAGE_DATA = {0,{0}};

extern struct StructQueue MPU_CAN_RX_QUEUE;
extern struct StructQueue GPS_CAN_RX_QUEUE;
extern struct StructQueue MOTOR_CAN_RX_QUEUE;
extern struct StructQueue PARTCL_CAN_RX_QUEUE;
extern struct StructQueue IMAGE_CAN_RX_QUEUE;

bool CAN_Mailbox0Empty = true;
bool CAN_Mailbox1Empty = true;
bool CAN_Mailbox2Empty = true;

//GPS DATA ID'S
extern uint32_t GPS_ID1;
extern uint32_t GPS_ID2;
extern uint32_t GPS_ID3;
extern uint32_t GPS_ID4;

//MPU DATA ID'S
extern uint32_t MPU_ID5;
extern uint32_t MPU_ID6;
extern uint32_t MPU_ID7;
extern uint32_t MPU_ID8;


//MOTOR DATA ID
extern uint32_t MOTOR_ID9;

//WATCHDOG DATA ID
extern uint32_t WATCHDOG_ID10;

// Recieved GPS data from CubeSAT
float GPS_LAT;
char GPS_LAT_DIR;
float GPS_LON;
char GPS_LON_DIR;
uint8_t GPS_QUALITY;
uint8_t GPS_HOURS;
uint8_t GPS_MINUTES;
uint8_t GPS_SEC;
float GPS_HDOP;
float GPS_ALTITUDE;
float GPS_H_GEOID;

//Recieved MPU data from CubeSAT
float MPU_ACCELX;
float MPU_ACCELY;
float MPU_ACCELZ;
float MPU_GYROX;
float MPU_GYROY;
float MPU_GYROZ;
float MPU_TEMP;

//Recieved MOTOR data from CubeSAT
uint8_t MOTOR_DUTYCYCLE;

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


void receiveData() {
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

void passToCanTX(struct CAN_QUEUE_DATA *data){
	if (CAN_Mailbox0Empty || CAN_Mailbox1Empty || CAN_Mailbox2Empty){
		sendData(can1, data->ID, PACKAGE_SIZE, data->data, TxHeader);
	}else {
		EnterStructQueue(&CAN_TX_QUEUE, data);
	}
}



void placeData_1( uint8_t *DataPass){

	LeaveStructQueue(&CAN_RX_QUEUE, &CAN_RX_QUEUE_DATA);


	//PLACE GPS DATA


		if(CAN_RX_QUEUE_DATA.ID == GPS_ID1){ // [LAT_DIR, LAT]
		    memcpy(&GPS_LAT, &DataPass[1], sizeof(GPS_LAT));
		    GPS_LAT_DIR = DataPass[0];
		}

		if(CAN_RX_QUEUE_DATA.ID == GPS_ID2){ // [LON_DIR, LON]
			memcpy(&GPS_LON, &DataPass[1], sizeof(GPS_LON));
			GPS_LON_DIR = DataPass[0];
		}

		if(CAN_RX_QUEUE_DATA.ID == GPS_ID3){// [QUALITY, HOURS, MINUTES, SEC, HDOP]
			GPS_QUALITY = DataPass[0];
			GPS_HOURS = DataPass[1];
			GPS_MINUTES = DataPass[2];
			GPS_SEC = DataPass[3];
			memcpy(&GPS_HDOP, &DataPass[4], sizeof(GPS_HDOP));
		}

		if(CAN_RX_QUEUE_DATA.ID == GPS_ID4){// [ALTITUDE, H_GEOID]
			memcpy(&GPS_ALTITUDE, &DataPass[0], sizeof(GPS_ALTITUDE));
			memcpy(&GPS_H_GEOID, &DataPass[4], sizeof(GPS_H_GEOID));
		}

	// PLACE MPU DATA
		if(CAN_RX_QUEUE_DATA.ID == MPU_ID5){// [ACCELX, ACCELY]
			memcpy(&MPU_ACCELX, &DataPass[0], sizeof(MPU_ACCELX));
			memcpy(&MPU_ACCELY, &DataPass[4], sizeof(MPU_ACCELY));
		}
		if(CAN_RX_QUEUE_DATA.ID == MPU_ID6){// [ACCELZ, GYROX]
			memcpy(&MPU_ACCELZ, &DataPass[0], sizeof(MPU_ACCELZ));
			memcpy(&MPU_GYROX, &DataPass[4], sizeof(MPU_GYROX));
		}
		if(CAN_RX_QUEUE_DATA.ID == MPU_ID7){// [GYROY, GYROZ]
			memcpy(&MPU_GYROY, &DataPass[0], sizeof(MPU_GYROY));
			memcpy(&MPU_GYROZ, &DataPass[4], sizeof(MPU_GYROZ));
		}
		if(CAN_RX_QUEUE_DATA.ID == MPU_ID8){// [TEMP]
			memcpy(&MPU_TEMP, &DataPass[0], sizeof(MPU_TEMP));
		}

	// PLACE DUTY CYCLE
		if(CAN_RX_QUEUE_DATA.ID == MOTOR_ID9){// [DUTYCYCLE]
			memcpy(&MOTOR_DUTYCYCLE, &DataPass[0], sizeof(MOTOR_DUTYCYCLE));
		}


	//WATCHDOG
		if(CAN_RX_QUEUE_DATA.ID == WATCHDOG_ID10){// [WATCHDOG]
			char str[15] = {0};
			sprintf(str, "%s", "WATCHDOG" );
			HAL_UART_Transmit(uart2, str, strlen(str), 100);
			HAL_UART_Transmit(uart2, "\n", 2, 100);				//Newline
			HAL_UART_Transmit(uart2, "\r", 2, 100);				//Carriage return
		}

}


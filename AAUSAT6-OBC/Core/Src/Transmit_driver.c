/*
 * Transmit.c
 *
 *  Created on: Apr 14, 2021
 *      Author: Michael
 */


#include "circle_queue.h"
#include "transmit_driver.h"
#include "gpsdriver.h"
#include "DCMotorDriver.h"
#include "mpu6050_driver.h"
#include "stdbool.h"
extern GPS_FIX_DATA data;
extern Axes3 resultGyro;
extern Axes3 resultAccel;
extern float tempVal;
extern uint32_t ARR;
extern uint32_t CaptureDCMotor;
extern bool CAN_Mailbox0Empty;
extern bool CAN_Mailbox1Empty;
extern bool CAN_Mailbox2Empty;


/* USER CODE BEGIN PV */
struct Queue queueRAM = {0, 0, {0}};
struct Queue queueRx = {0, 0, {0}};
#define PACKAGE_SIZE 8


/* USER CODE END PV */

void floatTo4UIntArray(float floatData, uint8_t *destinationArray){
	uint8_t *ptr;
	ptr = (uint8_t *)(&floatData);

	for(int i = 0; i<4; i++){
		destinationArray[i] = ptr[i];
	}

}

void sendGPS(CAN_HandleTypeDef *handler, CAN_TxHeaderTypeDef *transmitHeader){

	uint8_t Array1ID = 0x1;
	uint8_t Array2ID = 0x2;
	uint8_t Array3ID = 0x3;
	uint8_t Array4ID = 0x4;


//Formatering
	uint8_t ID1Array[8] = {0};
	uint8_t ID2Array[8] = {0};
	uint8_t ID3Array[8] = {0};
	uint8_t ID4Array[8] = {0};



//Formatering af ID1Array(); Det er [LAT_DIR, LAT, 0,0,0]
	floatTo4UIntArray(data.LAT, &ID1Array[1]);
	ID1Array[0]=(uint8_t) data.LAT_DIR;
	for (int i = 0; i < 3; i++ ) {
		ID1Array[i+5] = 0;

}
	//Formatering af ID2Array(); Det er [LON_DIR, LON, 0,0,0]
		floatTo4UIntArray(data.LON, &ID2Array[1]);
		ID2Array[0]=(uint8_t) data.LON_DIR;
		for (int i = 0; i < 3; i++ ) {
			ID1Array[i+5] = 0;
		}
	//Formatering af ID3Array(); Det er [QUALITY,HOURS,MIN,SEC,HDOP]
			ID3Array[0] = data.QUALITY;
			ID3Array[1] = data.HOURS;
			ID3Array[2] = data.MIN;
			ID3Array[3] = data.SEC;
			floatTo4UIntArray(data.HDOP, &ID3Array[4]);



	// Formattering af ID4Array(); [
			floatTo4UIntArray(data.ALTITUDE, &ID4Array);
			floatTo4UIntArray(data.H_GEOID, &ID4Array[4]);


	//SendData();
			sendData(handler, Array1ID, PACKAGE_SIZE, &ID1Array,  transmitHeader);
			sendData(handler, Array2ID, PACKAGE_SIZE, &ID2Array,  transmitHeader);
			sendData(handler, Array3ID, PACKAGE_SIZE, &ID3Array,  transmitHeader);
			sendData(handler, Array4ID, PACKAGE_SIZE, &ID4Array,  transmitHeader);


}

void sendMCU(CAN_HandleTypeDef *handler, CAN_TxHeaderTypeDef *transmitHeader){

//ID til data for MCU
uint8_t Array5ID = 0x5;
uint8_t Array6ID = 0x6;
uint8_t Array7ID = 0x7;
uint8_t Array8ID = 0x8;


uint8_t ID5Array[8] = {0};
uint8_t ID6Array[8] = {0};
uint8_t ID7Array[8] = {0};
uint8_t ID8Array[8] = {0};


//Formatering for ID5Array(); [resultAccel.x, resultAccel.y]

floatTo4UIntArray(resultAccel.x, &ID5Array);
floatTo4UIntArray(resultAccel.y, &ID5Array[4]);

//Fomratering for ID6Array(); [resultAccel.Z, resultGyro.x]
floatTo4UIntArray(resultAccel.z, &ID6Array);
floatTo4UIntArray(resultGyro.x, &ID6Array[4]);

//Formatering for ID7Array(); [ResultGyro.y, resultGyro.z]
floatTo4UIntArray(resultGyro.y, &ID7Array);
floatTo4UIntArray(resultGyro.z, &ID7Array[4]);

//Formatering for ID8Array();  [temperatur, 0000 4 gange]
floatTo4UIntArray(tempVal,&ID8Array);
for (int i = 0; i < 3; i++ ) {
			ID8Array[i+4] = 0;
}

//SendData();
			sendData(handler, Array5ID, PACKAGE_SIZE, &ID5Array,  transmitHeader);
			sendData(handler, Array6ID, PACKAGE_SIZE, &ID6Array,  transmitHeader);
			sendData(handler, Array7ID, PACKAGE_SIZE, &ID7Array,  transmitHeader);
			sendData(handler, Array8ID, PACKAGE_SIZE, &ID8Array,  transmitHeader);



}

void sendDCMotor(CAN_HandleTypeDef *handler, CAN_TxHeaderTypeDef *transmitHeader){
	uint8_t Array9ID = 0x9;


	//Formatering
	uint8_t ID9Array[0] = {0};

	uint8_t dutycycle = (CaptureDCMotor*100)/ARR;
	ID9Array[0] = dutycycle;
	for(int i=1; i>8; i++){
		ID9Array[i] = 0;


	}
	sendData(&handler, Array9ID, PACKAGE_SIZE, &ID9Array,  &transmitHeader);



}



void sendData(CAN_HandleTypeDef *handler, uint32_t TxID, uint16_t numOfBytes, uint8_t *dataArray, CAN_TxHeaderTypeDef *transmitHeader) {
	uint8_t dataToMB[PACKAGE_SIZE] = {0};
	uint32_t randoMailBox;
	transmitHeader->ExtId = TxID;
	uint32_t tsr = READ_REG(handler->Instance->TSR);

if (numOfBytes % PACKAGE_SIZE == 0)
{
	for (int i = 0; i < numOfBytes/PACKAGE_SIZE; i++) {
		while (HAL_CAN_GetTxMailboxesFreeLevel(handler) == 0) {}
		if (messageSplitter(dataArray, dataToMB, i)) {
			if (HAL_CAN_AddTxMessage(handler, transmitHeader, dataToMB, &randoMailBox) != HAL_OK) {
				Error_Handler();

			}
			if((tsr & CAN_TSR_TME0) != 0U){
				CAN_Mailbox0Empty = true;
			}else {
				CAN_Mailbox0Empty = false;

			}
			if((tsr & CAN_TSR_TME1) != 0U){
				CAN_Mailbox1Empty = true;
			}else {
				CAN_Mailbox1Empty = false;

			}
			if((tsr & CAN_TSR_TME2) != 0U){
				CAN_Mailbox2Empty = true;
			}else {
				CAN_Mailbox2Empty = false;

			}
		}
	}

}
else {return;}

}

int messageSplitter(uint8_t *sourceArray, uint8_t *destinationArray, uint8_t position)
{



	for(int i=0 ; i < PACKAGE_SIZE; i++)
	{
		*(destinationArray + i) = *(sourceArray + (position * 8) + i);


}
return 1;
}

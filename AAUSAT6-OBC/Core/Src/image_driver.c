#include "image_driver.h"


uint32_t IMAGE_DATA_ID = 0x5;
struct CAN_QUEUE_DATA IMAGE_DATA = {0,{0}};
struct StructQueue IMAGE_CAN_RX_QUEUE = {0};


// Vi skal have en funktion som bare tager et billede som kan kaldes af partcl


void image(){
	if(UnreadElements(&IMAGE_CAN_RX_QUEUE)){

		LeaveStructQueue(&IMAGE_CAN_RX_QUEUE, &IMAGE_DATA); //Hvad er der blevet bedt om
		//getImage(data); //Få hvad end der er blevet bedt om


		//TODO: sort rx data and gather what's requested

		passToCanTX(&IMAGE_DATA); // Sæt i TX queue

	}else{

		return;
	}
}

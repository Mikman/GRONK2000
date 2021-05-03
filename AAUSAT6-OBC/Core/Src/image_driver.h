

#ifndef IMAGE_DRIVER_H
#define IMAGE_DRIVER_H



#include "can_driver.h"
#include "circle_queue_struct.h"

#include <stdint.h>
#include "stm32l4xx_hal.h"

#define CAN_ID_COORDINATE 32
#define CAN_ID_DATA 33



enum CAM_STATUS {
    READY,        // Når vi er klar til at modtage en ny linje
    RECEIVING,    // Når vi er i færd med at modtage nye pixels
    WAITING,     // Når vi venter på plads i CAN-køen
    STANDBY        // Når vi ikke er igang med eller har planlagt noget
};

typedef struct {
    uint16_t x, y, width, height;
} Picture;

typedef struct {
    DMA_HandleTypeDef *hdma;
    TIM_HandleTypeDef *requestDataTimer;
    TIM_HandleTypeDef *DMATimer;
    uint32_t requestDataChannel;
    uint32_t DMAChannel;
    Picture *pic;
    enum CAM_STATUS status;
    uint32_t *source;
    uint8_t *destination;
    uint8_t I2C_Address;
    I2C_HandleTypeDef *I2C_Handler;
} CAM_HandleTypeDef;



void CAM_Handle_Init(CAM_HandleTypeDef *cam, DMA_HandleTypeDef *DMA_TimerChannel, TIM_HandleTypeDef *htim, I2C_HandleTypeDef *i2cHandle);
void CAM_toOutputQueue(CAM_HandleTypeDef *cam);
void CAM_update(CAM_HandleTypeDef *cam);
void CAM_setReg(CAM_HandleTypeDef *cam, uint8_t reg_addr, uint8_t value);
int CAM_getReg(CAM_HandleTypeDef *cam, int reg_addr);
void CAM_startLineTransfer(CAM_HandleTypeDef *cam);
void CAM_stopLineTransfer(CAM_HandleTypeDef *cam);
void CAM_takePicture(CAM_HandleTypeDef *cam);



void image();


#endif /* IMAGE_DRIVER_H */

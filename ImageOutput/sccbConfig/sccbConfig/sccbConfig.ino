#include "Wire.h"
/*
int address = 42;
int reg = 61;
int value = 0b11000000;

*/void configReg(int address, int setting){
Wire.beginTransmission(0x21); //Address of camera.
Wire.write(address);  // send desired register
Wire.write(setting);  // send desired bit setup
Wire.endTransmission();
delay(50);
}
void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
Wire.begin();

// YCbCr
configReg(0x12, 0x80); //Software reset 

configReg(0x1E, 0x10);  //Flip image vertically
configReg(0x13, 0x81); //Auto gain enable, White balance enable, Auto exposure enable
//configReg(0x3f, 0x01); //Edge enhancement factor 

/* FOR RGB
configReg(0x12, 0x84); //Software reset and configure RGB format
configReg(0x40, 0xD0); //Opsætter fuldt RBG output fra (0-255) og RGB 565
configReg(0x1E, 0x8);  //Flip image vertically
configReg(0x13, 0x07); //Auto gain enable, Auto exposure enable, White balance enable
configReg(0x3f, 0x1f); //Edge enhancement factor 
configReg(0x43, 0x0a); //Random config to improve white balance
configReg(0x45, 0x34); // -||-
configReg(0x47, 0x28); // -||-
configReg(0x59, 0x88); // -||-
configReg(0x5b, 0x44); // -||-
configReg(0x5d, 0x49); // -||-
configReg(0x6c, 0x0a); // -||-
configReg(0x6e, 0x11); // -||-
configReg(0x43, 0x0a); // -||-
configReg(0x6a, 0x40); // -||-
configReg(0x44, 0xf0); // -||-
configReg(0x46, 0x58); // -||-
configReg(0x48, 0x3a); // -||-
configReg(0x5a, 0x88); // -||-
configReg(0x5c, 0x67); // -||-
configReg(0x5e, 0x0e); // -||-
configReg(0x6d, 0x55); // -||-
configReg(0x6f, 0x9e); // -||-

*/

//Receive one transmission.
Wire.beginTransmission(0x21); // slave id
Wire.write(0x01);  // Read-from address
Wire.endTransmission();
Wire.requestFrom(0x21, 1);

Serial.println("Waits for SCCB comm.");

while (Wire.available() == 0);  //block till u get something
while (Wire.available())
  Serial.println(Wire.read(), HEX);

Serial.println("Done!");
}




void loop() {
  // put your main code here, to run repeatedly:
// reading

}

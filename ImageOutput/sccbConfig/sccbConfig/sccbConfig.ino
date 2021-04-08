#include "Wire.h"
/*
int address = 42;
int reg = 61;
int value = 0b11000000;

*/
void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
Wire.begin();
Wire.beginTransmission(0x21);
Wire.write(0x3D);  // software reset
Wire.write(0xC0);
Wire.endTransmission();
delay(500); // wait for reset to complete
Wire.beginTransmission(0x21);
Wire.write(0x1E);  // software reset
Wire.write(0x8);
Wire.endTransmission();
delay(500);

Wire.beginTransmission(0x21); 
Wire.write(0x1E);  // u now read from reg 0x01
Wire.endTransmission();
Wire.requestFrom(0x21, 1);
while (Wire.available() == 0);  //block till u get something
while (Wire.available())
  Serial.println(Wire.read(), HEX);
}




void loop() {
  // put your main code here, to run repeatedly:
// reading

}

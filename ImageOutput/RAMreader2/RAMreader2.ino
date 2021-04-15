#include "Wire.h"

#define OV7670_ADDR 0x21
#define pRequestData 12
#define pTransfer 25
#define pGetImage 24
#define pLED 13

void setup() {
  // put your setup code here, to run once:
  Serial.begin (115200);
  Serial5.begin(115200);
  Wire.begin();
  
  pinMode (2, INPUT);
  pinMode (3, INPUT);
  pinMode (4, INPUT);
  pinMode (5, INPUT);
  pinMode (6, INPUT);
  pinMode (7, INPUT);
  pinMode (8, INPUT);
  pinMode (9, INPUT);
  
  pinMode (pRequestData, OUTPUT);
  pinMode (pTransfer, OUTPUT);
  pinMode (pGetImage, OUTPUT);
  pinMode (pLED, OUTPUT);

  configureCamera();
}

void configureCamera() {
  setCamReg(0x12, 0x80); //Software reset, YUV mode

  setCamReg(0x1E, 0x31);  //Flip image vertically and mirror
  setCamReg(0x13, 0x81); //Auto gain enable, White balance enable, Auto exposure enable
  setCamReg(0x3f, 0x01); //Edge enhancement factor 

  Serial.println("Camera registers:");
  getCamReg(0x12);
  getCamReg(0x1E);
  getCamReg(0x13);
  getCamReg(0x3f);
}

void setCamReg(int reg_address, int value) {
  Wire.beginTransmission(OV7670_ADDR); //Address of camera.
  Wire.write(reg_address);  // send desired register
  Wire.write(value);  // send desired bit setup
  Wire.endTransmission();
  delay(50);
}

void getCamReg(int reg_address) {
  Wire.beginTransmission(OV7670_ADDR); // slave id
  Wire.write(reg_address);  // Read-from address
  Wire.endTransmission();
  Wire.requestFrom(OV7670_ADDR, 1);
  
  Serial.print("0x");
  Serial.print(reg_address, HEX);
  Serial.print(": ");
  
  while (Wire.available() == 0);  //block till u get something
  while (Wire.available())
    Serial.println(Wire.read(), HEX);
}

void TakePicture() {

  
  // Take picture
  digitalWrite(pGetImage, HIGH);
  delay(100);
  digitalWrite(pGetImage, LOW);
  delay(100);
  Serial.println("Picture taken");
}

void ReadFromRAM() {
  // Read from RAM
  Serial.println("Reading from RAM.");
  
  digitalWrite(pLED, HIGH);
  digitalWrite(pTransfer, HIGH);
  
  for (uint16_t y = 0; y < 480; y++){
    for (uint16_t x = 0; x < 640; x++){
      Serial5.write(getPixelData());
      digitalWrite (pRequestData, HIGH);
      delayMicroseconds(5);
      digitalWrite (pRequestData, LOW);
      delayMicroseconds(5);
    }
  }

  digitalWrite(pLED, LOW);
  digitalWrite(pTransfer, LOW);

  for (uint8_t i = 0; i < 3; i++) {
    digitalWrite(pLED, HIGH);
    delay(500);
    digitalWrite(pLED, LOW);
    delay(500);
  }

  Serial.println("Transfer complete.");
}



char getPixelData() {

  char returnBYTE = 0;
  
  char BYTE = 0;
  for (int i = 0; i < 8; i++){
     returnBYTE = ((char)digitalRead (i + 2)) << i;
     BYTE = returnBYTE | BYTE;
  }
  return BYTE;
}

void loop() {
  while (Serial.available() > 0) {
    String str = Serial.readStringUntil('\n');
    if (str == "img") {
      TakePicture();
      ReadFromRAM();
    } else if (str == "read") {
      ReadFromRAM();
    } else if (str == "shoot") {
      TakePicture();
    }
  }
}

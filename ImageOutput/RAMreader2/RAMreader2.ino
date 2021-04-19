void setup() {
  // put your setup code here, to run once:
Serial1.begin (115200);
pinMode (2, INPUT);
pinMode (3, INPUT);
pinMode (4, INPUT);
pinMode (5, INPUT);
pinMode (6, INPUT);
pinMode (7, INPUT);
pinMode (8, INPUT);
pinMode (9, INPUT);

pinMode (12, OUTPUT);


}



char pixel() {

  char returnBYTE = 0;
  
  char BYTE = 0;
  for (int i = 0; i < 8; i++){
     returnBYTE = ((char)digitalRead (i + 2)) << i;
     BYTE = returnBYTE | BYTE;
  }
  return BYTE;
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(10000);
for (int i = 0; i < 640; i++){
  for (int x = 0; x < 480; x++){
    Serial1.print (pixel());
    digitalWrite (12, HIGH);
    delayMicroseconds(5);
    digitalWrite (12, LOW);
    delayMicroseconds(5);
  }
  
 
}
  while(true){
    
  }

}

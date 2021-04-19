// I/O 1-6 on Ram is connected to PB0-5 (8-13)
// I/O 7-8 on Ram is connected to PD6-7 (6-7)
// FPGA trigger is connected to PD5 

#define maskB 0b111111
#define maskD (_BV(6) | _BV(7))
#define InB (PINB & maskB)
#define InD (PIND & maskD)
#define RamData (InB | InD)

void setup() {
  // put your setup code here, to run once:
  Serial.begin (115200);

  // DDRB &= ~maskB; // Set as input
  // DDRD &= ~(maskD); // Set as input

  pinMode(6, INPUT);
  pinMode(7, INPUT);
  pinMode(8, INPUT);
  pinMode(9, INPUT);
  pinMode(10, INPUT);
  pinMode(12, INPUT);
  pinMode(13, INPUT);
  DDRD |= _BV(5); // set (5) as output)
}

void loop() {
  // put your main code here, to run repeatedly:
for (unsigned long i = 0; i < (unsigned long) 40; i++){
  
  Serial.print ((char) RamData);
  //while (Serial.availableForWrite()) {} // Wait until character has been succesfully sent
  delayMicroseconds(5);

  PORTD |= _BV(5);
  PORTD &= ~_BV(5);
}
  while(true){
    
  }

}

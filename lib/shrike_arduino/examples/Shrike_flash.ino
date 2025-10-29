#include <ShrikeFPGA.h>

ShrikeFPGA shrike;

void setup() {

  pinMode(4, OUTPUT);

  shrike.initShrike(); // intializing
  shrike.listFiles();  // optinal list the .bin files
  shrike.programShrike("/blink_all.bin"); // flash the FPGA 
}

void loop() {

  digitalWrite(4, HIGH);  
  delay(1000);                      
  digitalWrite(4, LOW);   
  delay(1000); 

}

#include <Wire.h>
#include <Time.h>
#include <DS1307RTC.h>


// Variable Definitions
const int relayControl = 8;
const int deadManTx = 2;
//ONLY INPUT PIN = 4
const int deadManRx = 4;
//const int vOut = 10;
const int forceDown = 6;
int countDown, missionAbort, signalMatch;
tmElements_t tm;

void setup() {
  pinMode(8, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(4, INPUT);
  //pinMode(10, OUTPUT);
  pinMode(6, OUTPUT);
  Serial.begin(9600);
  while (!Serial);
  delay(200);
  Serial.println("-- DISPLAY ONLINE --");
  //Uncomment for initial setup
  //setTime();
  

}

void loop(){
  digitalWrite(forceDown, LOW);
  RTC.read(tm);
  //digitalWrite(vOut, HIGH);
  digitalWrite(relayControl, HIGH);
  digitalWrite(deadManTx, LOW);
  //Serial.print(tm.Hour);
  //Serial.print(tm.Minute);
  Serial.print(tm.Hour);
  Serial.write(':');
  Serial.print(tm.Minute);
  Serial.write(':');
  Serial.print(tm.Second);
  Serial.println();
  if(tm.Second == 0 && tm.Minute == 0){
    signalMatch = digitalRead(deadManRx);
    digitalWrite(deadManTx, HIGH);
    for(countDown = 0; countDown < 900; countDown ++) {
      missionAbort = digitalRead(deadManRx);
      delay(1000);
      if(missionAbort != signalMatch) {
        digitalWrite(deadManTx, LOW);
        break;
      } else {
        Serial.write("Houston, we have a problem.");
        Serial.println();
        
        
      } 
      if(countDown == 899 ) {
        digitalWrite(relayControl, LOW);
        digitalWrite(deadManTx, LOW);
        delay(1000);
        break;
      }
    }
  }
  if(tm.Second == 00 && tm.Minute == 00 && tm.Hour == 23){
    digitalWrite(deadManTx, LOW);
    digitalWrite(forceDown, HIGH);
    Serial.write("Initiating daily reset. Waiting for ZedBoard to power off.");
    Serial.println();
    delay(60000);
    digitalWrite(relayControl, LOW);
    digitalWrite(forceDown, LOW);
    delay(3000);
  }
  delay(1000);
  
}


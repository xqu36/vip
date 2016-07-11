// Variable Definitions
const int relayControl = 13;
const int deadManTx = 12;
const int deadManRx = 11;
int missionAbort;
int countDown;


void setup() {
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, INPUT);
  pinMode(9, OUTPUT);

}

void loop(){
  digitalWrite(relayControl, HIGH);
  delay(5000);
  digitalWrite(deadManTx, HIGH);
  for(countDown = 0; countDown < 10; countDown ++) {
    missionAbort = digitalRead(deadManRx);
    delay(1000);
    if(missionAbort) {
      digitalWrite(deadManTx, LOW);
      break;
    } else {
      digitalWrite(9, HIGH);
      delay(1000);
      digitalWrite(9, LOW);
     } 
    if(countDown == 9) {
      digitalWrite(relayControl, LOW);
      digitalWrite(deadManTx, LOW);
      delay(2000);
      break;
    }
    }
  
}


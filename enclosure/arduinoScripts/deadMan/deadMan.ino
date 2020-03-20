#include <Wire.h>
#include <Time.h>
#include <DS1307RTC.h>


// VARIABLE DEFINITIONS
//
// Switch control for the power relay. Connects to S on relay.
const int relayControl = 8;
// Outgoing pin for health monitoring. Connects to JA3 on ZedBoard. 
const int deadManTx = 2;
// Pin 4 is the only input pin to be set in the rc.local
// in the /etc directory of the OS. Recieves signal from ZedBoard
// to stop a healthcheck reset.
// Connects to JA10 on ZedBoard.
const int deadManRx = 4;
// Output signal to indicate a forced shutdown of the board is occuring.
// FPGA will powerdown and wait for power cycle after receiving this signal.
// Connects to JA9.
const int forceDown = 6;
// CountDown used as counter.
// MissionAbort is value holder for healthcheck canceling.
// SignalMatch is variable to hold previous status of deadManRX to prevent
// constant high power resets. 
int countDown, missionAbort, signalMatch;
// creates tm structure for time values.
// tm.Second, tm.Minute, tm.Hour.
tmElements_t tm;


// SETUP LOOP
//
void setup() {
  pinMode(8, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(4, INPUT);
  pinMode(6, OUTPUT);
  // Initialize serial output for development purposes.
  Serial.begin(9600);
  while (!Serial);
  delay(200);
  Serial.println("-- DISPLAY ONLINE --");
  // setTime function will set the current time of the RTC. Must be used
  // in a complete circuit with RTC attached. After programming once to
  // set the time, uncomment to prevent a time reset after each power cycle.
  //setTime();
  

}

// MAIN LOOP
//
void loop(){
  // Initializing all pin values.
  digitalWrite(forceDown, LOW);
  digitalWrite(relayControl, HIGH);
  digitalWrite(deadManTx, LOW);
  // Grabbing current time from RTC.
  RTC.read(tm);
  // Printing time and data for development.
  Serial.print(tm.Hour);
  Serial.write(':');
  Serial.print(tm.Minute);
  Serial.write(':');
  Serial.print(tm.Second);
  Serial.println();
  // HEALTH CHECK FUNCTION
  //
  // Checks once per hour to make sure the FPGA is responsive.
  if(tm.Second == 00 && tm.Minute == 00){
    // Sets signalMatch and missionAbort to the current value of 
    // deadManRx for comparisson values to deteremine health of board.
    signalMatch = digitalRead(deadManRx);
    missionAbort = digitalRead(deadManRx);
    // Health monitor flag activated.
    digitalWrite(deadManTx, HIGH);
    // Countdown sequence. If the value of deadManRx is not flipped before 900 seconds
    // the health check sequence will recycle the power of the board.
    for(countDown = 0; countDown < 900; countDown ++) {
      delay(1000);
      // If statement activated if health of board is ok and no reset needed.
      if(missionAbort != signalMatch) {
        digitalWrite(deadManTx, LOW);
        break;
      } else {
        Serial.write("Houston, we have a problem.");
        Serial.println();
      }
      // If statement for an unresponsive board, recycles power and waits one second.
      if(countDown == 899 ) {
        digitalWrite(relayControl, LOW);
        digitalWrite(deadManTx, LOW);
        delay(1000);
        break;
      }
    }
  }
  // FORCE SHUTDOWN FUNCTION
  //
  // Once per day forces a power recycle. 
  if(tm.Second == 00 && tm.Minute == 00 && tm.Hour == 23){
    digitalWrite(deadManTx, LOW);
    // Sends signal to board to shutdown and prepare for reboot.
    digitalWrite(forceDown, HIGH);
    // Serial output for development feedback.
    Serial.write("Initiating daily reset. Waiting for ZedBoard to power off.");
    Serial.println();
    // Waits 1 minute for board to shutdown. Turns off power, and waits 3 seconds.
    delay(60000);
    digitalWrite(relayControl, LOW);
    digitalWrite(forceDown, LOW);
    delay(3000);
  }
  // Script checks time every second.
  delay(1000);
  
}


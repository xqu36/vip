/*
This code reads the Analog Voltage output from the
10 Meter HR-MaxSonar sensors
If you wish for code with averaging, please see
playground.arduino.cc/Main/MaxSonar
Please note that we do not recommend using averaging with our sensors.
Mode and Median filters are recommended.
*/

const int anPin1 = 0;
long dist,avgDist; 
int sum = 0;
int avgrange = 30; //averages 30 samples


void setup() {
  Serial.begin(9600);  // sets the serial port to 9600
}


void loop() {
  
 for(int i = 0; i < avgrange ; i++){
   dist = analogRead(anPin1);
   sum += dist;
   delay(50);
 }
 
avgDist = (sum/avgrange)   ;

Serial.println(avgDist);
sum = 0;

delay(50);
 
}





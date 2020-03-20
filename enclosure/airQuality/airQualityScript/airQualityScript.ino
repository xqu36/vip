#include <Wire.h>

int co2Addr = 0x68;

//PIN SETUP

int pin = A0;     //03 sensor
int pin1 = A1;    //03 aux
int pin2 = A2;     //CO sensor
int pin3 = A3;    //CO aux
int pin4 = A4;     // C02 sensor I2C
int pin5 = A5;    // CO2 sensor I2C
int pin6 = A6;     // NO2 sensor
int pin7 = A7;    // N02 aux

//CALCULATION VARIABLES

float O3sensor;
float O3aux;
float O3;
float COsensor;
float COaux;
float CO;
float NO2sensor;
float NO2aux;
float NO2;

//ALPHASENSE VALUES

float O3sensoroff = 238;
float O3auxoff = 232;
float O3sens = .321;
float COsensoroff = 445;
float COauxoff = 321;
float COsens = .422;
float NO2sensoroff = 222;
float NO2auxoff = 229;
float NO2sens = .216;


void setup() {

    Serial.begin(9600); //sets the baud rate at 9600 bps
    Wire.begin ();
    pinMode(13, OUTPUT);  // We will use this pin as a read‐indicator
    Serial.println("Starting data collection...");

}

void wakeSensor() {
  // This command serves as a wakeup to the CO2 sensor, for K33‐ELG/BLG Sensors Only

  // You'll have the look up the registers for your specific device, but the idea here is simple:
  // 1. Disabled the I2C engine on the AVR
  // 2. Set the Data Direction register to output on the SDA line
  // 3. Toggle the line low for ~1ms to wake the micro up. Enable I2C Engine
  // 4. Wake a millisecond.

  TWCR &= ~(1<<2); // Disable I2C Engine
  DDRC |= (1<<4); // Set pin to output mode
  PORTC &= ~(1<<4); // Pull pin low
  delay(1);
  PORTC |= (1<<4); // Pull pin high again
  TWCR |= (1<<2); // I2C is now enabled
  delay(1);     
}
///////////////////////////////////////////////////////////////////
// Function : void initPoll()
// Executes : Tells sensor to take a measurement.
// Notes    : A fuller implementation would read the register back and
//            ensure the flag was set, but in our case we ensure the poll
//            period is >25s and life is generally good.
///////////////////////////////////////////////////////////////////

void initPoll() {
  Wire.beginTransmission(co2Addr);
  Wire.write(0x11);
  Wire.write(0x00);
  Wire.write(0x60);
  Wire.write(0x35);
  Wire.write(0xA6);

  Wire.endTransmission();
  delay(20);  
  Wire.requestFrom(co2Addr, 2);

  byte i = 0;
  byte buffer[2] = {
    0, 0  };
  while(Wire.available()) {
    buffer[i] = Wire.read();
    i++;
  }   

}

///////////////////////////////////////////////////////////////////
// Function : double readCo2()
// Returns  : The current CO2 Value, ‐1 if error has occured
///////////////////////////////////////////////////////////////////

double readCo2() {
  int co2_value = 0;                     
  // We will store the CO2 value inside this variable.
  digitalWrite(13, HIGH);                
  // On most Arduino platforms this pin is used as an indicator light.  

  //////////////////////////
  /* Begin Write Sequence */
  //////////////////////////

  Wire.beginTransmission(co2Addr);
  Wire.write(0x22);
  Wire.write(0x00);
  Wire.write(0x08);
  Wire.write(0x2A);

  Wire.endTransmission();
  /*
     We wait 10ms for the sensor to process our command.
   The sensors's primary duties are to accurately
   measure CO2 values. Waiting 10ms will ensure the
   data is properly written to RAM
   
   */
  delay(20);
  /////////////////////////  
  /* Begin Read Sequence */
  /////////////////////////
  /*
     Since we requested 2 bytes from the sensor we must
   read in 4 bytes. This includes the payload, checksum,
   and command status byte.
   */

  Wire.requestFrom(co2Addr, 4);

  byte i = 0;
  byte buffer[4] = {
    0, 0, 0, 0  };

  /*  
   Wire.available() is not nessessary. Implementation is obscure but we leave
   it in here for portability and to future proof our code
   */
  while(Wire.available()) {
    buffer[i] = Wire.read();
    i++;
  }   

  co2_value = 0;
  co2_value |= buffer[1] & 0xFF;
  co2_value = co2_value << 8;
  co2_value |= buffer[2] & 0xFF;

  byte sum = 0;                              //Checksum Byte
  sum = buffer[0] + buffer[1] + buffer[2];   //Byte addition utilizes overflow

  if(sum == buffer[3]) {
    // Success!
    digitalWrite(13, LOW);
    return ((double) co2_value / (double) 1);
  }   
  else {
    // Failure!
    /*
        Checksum failure can be due to a number of factors,
     fuzzy electrons, sensor busy, etc.
     */

    digitalWrite(13, LOW);
    return (double) - 1;
  }   
}
///////////////////////////////////////////////////////////////////
// Function : double readTemp()
// Returns  : The current Temperture Value, ‐1 if error has occured
///////////////////////////////////////////////////////////////////

double readTemp() {
  int tempVal = 0;    

  digitalWrite(13, HIGH);      

  Wire.beginTransmission(co2Addr);
  Wire.write(0x22);
  Wire.write(0x00);
  Wire.write(0x12);
  Wire.write(0x34);

  Wire.endTransmission();

  delay(20);

  Wire.requestFrom(co2Addr, 4);

  byte i = 0;
  byte buffer[4] = {
    0, 0, 0, 0  };

  while(Wire.available()) {
    buffer[i] = Wire.read();
    i++;
  }   

  tempVal = 0;
  tempVal |= buffer[1] & 0xFF;
  tempVal = tempVal << 8;
  tempVal |= buffer[2] & 0xFF;

  byte sum = 0;                              //Checksum Byte
  sum = buffer[0] + buffer[1] + buffer[2];   //Byte addition utilizes overflow

  if(sum == buffer[3]) {
    digitalWrite(13, LOW);
    return ((double) tempVal / (double) 100);
  }   

  else {
    digitalWrite(13, LOW);
    return -1;
  }   

}

///////////////////////////////////////////////////////////////////
// Function : double readRh()
// Returns  : The current Rh Value, ‐1 if error has occured
///////////////////////////////////////////////////////////////////

double readRh() {
  int tempVal = 0;    

  digitalWrite(13, HIGH);  

  Wire.beginTransmission(co2Addr);
  Wire.write(0x22);
  Wire.write(0x00);
  Wire.write(0x14);
  Wire.write(0x36);

  Wire.endTransmission();

  delay(20);  

  Wire.requestFrom(co2Addr, 4);

  byte i = 0;
  byte buffer[4] = {
    0, 0, 0, 0  };
  while(Wire.available()) {
    buffer[i] = Wire.read();
    i++;
  }  

  tempVal = 0;
  tempVal |= buffer[1] & 0xFF;
  tempVal = tempVal << 8;
  tempVal |= buffer[2] & 0xFF;

  byte sum = 0;                              //Checksum Byte
  sum = buffer[0] + buffer[1] + buffer[2];   //Byte addition utilizes overflow

  if(sum == buffer[3]) {
    digitalWrite(13, LOW);
    return (double) tempVal / (double) 100;
  }   
  else {
    digitalWrite(13, LOW);
    return -1;
  }    
}

void loop() {

  //COLLECT DATA
  
  wakeSensor();
  initPoll(); 
  delay(16000);
  wakeSensor();
  double tempValue = readTemp();
  delay(20);
  wakeSensor();
  double rhValue = readRh();
  delay(20);
  wakeSensor();
  double co2Value = readCo2();
 
  O3sensor = analogRead(pin);
  O3aux = analogRead(pin1);
  delay(1000);
  COsensor = analogRead(pin2);
  COaux = analogRead(pin3);
  delay(1000);
  NO2sensor = analogRead(pin6);
  NO2sensor = analogRead(pin7);
  
  //PROCESSING
  
  O3sensor = (O3sensor * (5/1024)) - O3sensoroff;
  O3aux = (O3aux * (5/1024)) - O3auxoff;
  O3 = (O3sensor - O3aux) / O3sens;
  
  COsensor = (COsensor * (5/1024)) - COsensoroff;
  COaux = (COaux * (5/1024)) - COauxoff;
  CO = (COsensor - COaux) / COsens;
  
  NO2sensor = (NO2sensor * (5/1024)) - NO2sensoroff;
  NO2aux = (NO2aux * (5/1024)) - NO2auxoff;
  NO2 = (NO2sensor - NO2aux) / NO2sens;

  //OP1 = OP1 * 5.0 / 1024; //convert anolog outs back to a voltage
  //OP2 = OP2 * 5.0 / 1024;
  //WeVo = OP1 - WeV;     //corrects reading with the offset voltage found in the second column of table 2 in doc 085-2217
  //AuxVo = OP2 - AuxV;     //corrects aux reading with the same offset voltage
  //ppm1 = WeVo/sens;     //non aux electrod ppm measurement, sensibility measurment found on bag of sensor
  //WeAux = WeVo - AuxVo;  //corrects for drift in Aux and We probes ie OP1 and OP2
  //ppm2 = WeAux/sens;    //aux corrected ppm reading

  //SEND
 
  Serial.println("O3: ");
  Serial.println(O3);
  Serial.println("CO: ");
  Serial.println(CO);
  Serial.println("NO2: ");
  Serial.println(NO2);
  
  if(co2Value >= 0) {
    Serial.println("CO2: ");
    Serial.println(co2Value);
    Serial.println("ppm Temp: ");
    Serial.println(tempValue);
    Serial.println("C Rh: ");
    Serial.println(rhValue);
    Serial.println("%");
  }     
  else {
    Serial.println("Checksum failed / Communication failure");
  }     
  delay(9000);
 
}

// CO2 Meter K‐series Example Interface
// by Andrew Robinson, CO2 Meter <co2meter.com>
// Talks via I2C to K33‐ELG/BLG Sensors for Host‐Initiated Data Collection
// 4.1.2011

#include <Wire.h>

// We will be using the I2C hardware interface on the Arduino in
// combination with the built‐in Wire library to interface.
//  Arduino analog input 5 ‐ I2C SCL
//  Arduino analog input 4 ‐ I2C SDA
/*
  In this example we will do a basic read of the CO2 value and checksum verification.
 For more advanced applications please see the I2C Comm guide.
 */
int co2Addr = 0x68;    
// This is the default address of the CO2 sensor, 7bits shifted left.
void setup() {
  Serial.begin(115200);     
  Wire.begin ();
  pinMode(13, OUTPUT);  // We will use this pin as a read‐indicator
  Serial.println("What a wonderful day, to read atmospheric CO2 concentrations!");
}

///////////////////////////////////////////////////////////////////
// Function : void wakeSensor()
// Executes : Sends wakeup commands to K33 sensors.
// Note     : THIS COMMAND MUST BE MODIFIED FOR THE SPECIFIC AVR YOU ARE USING
//            THE REGISTERS ARE HARD‐CODED
/////////////////////////////////////////////////////////////////

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
  // We keep the sample period >25s or so, else the sensor will start ignoring sample requests.
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

  if(co2Value >= 0) {
    Serial.print("CO2: ");
    Serial.print(co2Value);
    Serial.print("ppm Temp: ");
    Serial.print(tempValue);
    Serial.print("C Rh: ");
    Serial.print(rhValue);
    Serial.println("%");
  }     
  else {
    Serial.println("Checksum failed / Communication failure");
  }     
  delay(9000);
}


#include <Adafruit_ADS1015.h>

#include <Wire.h>

Adafruit_ADS1115 ads;  /* Use this for the 16-bit version */
/*Adafruit_ADS1015 ads;    /* Use thi for the 12-bit version */
int average;
int windowIR[30];
int windowUltra[30];
int i;
int IRval;
int UltraVal;
void setup(void) 
{
  Serial.begin(9600);
  Serial.println("Hello!");
  
  Serial.println("Getting single-ended readings from AIN0..3");
  Serial.println("ADC Range: +/- 6.144V (1 bit = 3mV/ADS1015, 0.1875mV/ADS1115)");
  
  // The ADC input range (or gain) can be changed via the following
  // functions, but be careful never to exceed VDD +0.3V max, or to
  // exceed the upper and lower limits if you adjust the input range!
  // Setting these values incorrectly may destroy your ADC!
  //                                                                ADS1015  ADS1115
  //                                                                -------  -------
  // ads.setGain(GAIN_TWOTHIRDS);  // 2/3x gain +/- 6.144V  1 bit = 3mV      0.1875mV (default)
  // ads.setGain(GAIN_ONE);        // 1x gain   +/- 4.096V  1 bit = 2mV      0.125mV
  // ads.setGain(GAIN_TWO);        // 2x gain   +/- 2.048V  1 bit = 1mV      0.0625mV
  // ads.setGain(GAIN_FOUR);       // 4x gain   +/- 1.024V  1 bit = 0.5mV    0.03125mV
  // ads.setGain(GAIN_EIGHT);      // 8x gain   +/- 0.512V  1 bit = 0.25mV   0.015625mV
  // ads.setGain(GAIN_SIXTEEN);    // 16x gain  +/- 0.256V  1 bit = 0.125mV  0.0078125mV
  
  ads.begin();
  delay(500);
  Serial.println("calibrating...");
  
  for(i = 0; i < 10; i++) {
    IRval = ads.readADC_SingleEnded(0);
    UltraVal = ads.readADC_SingleEnded(1);
    if (IRval > 2000) {
      windowIR[i] = IRval;
      windowUltra[i] = UltraVal;
    } else {
      i--;
    }
    //average = (average*(i-1) + ads.readADC_SingleEnded(0))/i;
    average += IRval;
    delay(500);
  }
  average = average/i;
  Serial.print("IR average is: ");
  Serial.println(average);
}

void loop(void) 
{
  int16_t adc0;//, adc1, adc2, adc3;

  adc0 = ads.readADC_SingleEnded(0);
  windowIR[i] = adc0;
  //adc1 = ads.readADC_SingleEnded(1);
  //adc2 = ads.readADC_SingleEnded(2);
  //adc3 = ads.readADC_SingleEnded(3);
  Serial.println(windowIR[i]);
  average = (average*(i-1)) + adc0;
  Serial.println(average);
  //Serial.print("AIN1: "); Serial.println(adc1);
  //Serial.print("AIN2: "); Serial.println(adc2);
  //Serial.print("AIN3: "); Serial.println(adc3);
  
  delay(1000);
  i = (i++)%30;
}


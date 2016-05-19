# Simple demo of continuous ADC conversion mode for channel 0 of the ADS1x15 ADC.
# Author: Tony DiCola
# License: Public Domain
import time

# Import the ADS1x15 module.
import Adafruit_ADS1x15


# Create an ADS1115 ADC (16-bit) instance.
adc = Adafruit_ADS1x15.ADS1115()

GAIN = 1
IRvalues = []
USvalues = []

start = time.time()
f = open('IR_US_log', 'w')
while (time.time() - start) <= 10.0:
    # Read the last ADC conversion value and print it out.
    valIR = adc.read_adc(0, gain=GAIN)
    valUS = adc.read_adc(1, gain=GAIN)
    IRvalues.append(valIR)
    USvalues.append(valUS)
    f.write('{0}: {1},{2}\n'.format(time.time(),valIR,valUS))
    # Sleep for half a second.
    time.sleep(0.5)

# Stop continuous conversion.  After this point you can't get data from get_last_result!
adc.stop_adc()

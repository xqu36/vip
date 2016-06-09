import os
import subprocess
import time
import datetime
from Adafruit_ADS1x15.Adafruit_ADS1x15 import ADS1x15 
import numpy as np
#import csv
#import json
try:
    from cStringIO import StringIO
except:
    from StringIO import StringIO
#import csv
#import json
subprocess.call(['/sbin/modprobe', 'i2c-dev'])    #calls a function from the command line #This is how you configure the i2c tools
time.sleep(3)
sensor_id = 3
ADS1115 = 0x01 # chip identifier for ADC library
sensorADC = ADS1x15(ic=ADS1115)
gain = 4096 # May have to change this
sps = 250 # May have to change this

try:
    from cStringIO import StringIO
except:
    from StringIO import StringIO 
while True:
	COAvg = sensorADC.readADCSingleEnded(2, gain, sps)
	print(COAvg)
	time.sleep(.5)
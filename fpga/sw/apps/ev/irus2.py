#This code takes input from an ultrasonic and infrared sensor and outputs a json file
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

# Initialize GPIO and I2C
subprocess.call(['/sbin/modprobe', 'i2c-dev'])    #calls a function from the command line #This is how you configure the i2c tools
time.sleep(3)

# Initialize Sensor Set
sensor_id = 3
interval = 0.25#int(raw_input("How many seconds in between sensor reads?\t\tEnter an integer:\t"))

#Initialize filtering variables
windowIR=[0]*10 #creates vector of 0s
windowUS=[0]*10
windowPS=[0]*10
windowUV=[0]*10
i = 0

#Set up sensors
ADS1115 = 0x01 # chip identifier for ADC library
sensorADC = ADS1x15(ic=ADS1115)
gain = 4096 # May have to change this
sps = 250 # May have to change this

def movingAvg(values,window): #This is just a function to calculate the average of outputs
	weights = np.repeat(1.0,window)/window
	smas = np.convolve(values,weights,'valid')
	return smas

fields = ["timestamp", "valid", "sensor", "data1"]
inittime = time.time()
initname = str(int(inittime)) + ".json"
timo = inittime + 30
strio = StringIO()
infrared = 0

abc = 0 #This is temporary

while abc < 20:
	abc = abc + 1
	
	for i in range (0,10):
		infrared = sensorADC.readADCSingleEnded(0, gain, sps)
      	windowIR[i] = infrared
	
	for i in range (0,10):
		ultrasonic = sensorADC.readADCSingleEnded(1, gain, sps)
		windowUS[i] =  ultrasonic

	for i in range (0,10):
		pressure = sensorADC.readADCSingleEnded(2, gain, sps)
		windowPS[i] =  pressure

	for i in range (0,10):
		ultraviolet = sensorADC.readADCSingleEnded(3, gain, sps)
      	windowUV[i] = ultraviolet

	IRAvg = movingAvg(windowIR,10)
	USAvg = movingAvg(windowUS,10)
	PSAvg = movingAvg(windowPS,10)
	UVAvg = movingAvg(windowUV,10)
	print "Infrared = %d ultrasonic = %d pressure = %d ultraviolet = %d" % (IRAvg, USAvg, PSAvg, UVAvg)
	if time.time() > timo:
		break
	time.sleep(interval)
print("Done with 20 iterations")

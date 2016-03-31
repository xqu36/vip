#!/usr/bin/env python
import os
import subprocess
import time
import datetime
from pytz import timezone
import pytz
from Adafruit_ADS1x15.Adafruit_ADS1x15 import ADS1x15
from Adafruit_TCS34725.Adafruit_TCS34725 import TCS34725
import SI1145.SI1145 as SI1145
import Adafruit_BMP.BMP085 as BMP085
import numpy as np

# Initialize GPIO and I2C
bashCommand = "sudo killall pigpiod"
print "STATUS: Removing lock on pigpiod"
subprocess.Popen(bashCommand, shell=True)
time.sleep(3)
print "STATUS: Setting up GPIO and I2C"
subprocess.call(['/sbin/modprobe', 'i2c-dev'])
subprocess.call(['/sbin/modprobe', 'i2c-bcm2708'])
subprocess.call(['/usr/local/bin/pigpiod'])
time.sleep(3)

# Initialize Time
timezone_eastern = timezone('US/Eastern')

# Initialize Sensor Set
sensor_id = 3

#Initialize filtering variables
windowIR[10]
windowUS[10]
i = 0


# User Configuration
interval = 0.25#int(raw_input("How many seconds in between sensor reads?\t\tEnter an integer:\t"))
connectedADC = bool(raw_input("Is the ADC connected to the I2C bus?\t\t\tEnter y or n:\t\t") == 'y')
if connectedADC:
	connectedIR = bool(raw_input("Is the infrared sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
	if connectedIR:
		channelIR = int(raw_input("What ADC channel is the IR sensor using?\t\tEnter 0, 1, 2, or 3:\t"))
	connectedUS = bool(raw_input("Is the ultrasonic sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
	if connectedUS:
		channelUS = int(raw_input("What ADC channel is the ultrasonic sensor using?\tEnter 0, 1, 2, or 3:\t"))

# Set up sensors given by user
print "STATUS: Seting Up Sensors"
if connectedADC:
	ADS1115 = 0x01 # chip identifier for ADC library
	sensorADC = ADS1x15(ic=ADS1115)
	gain = 4096
	sps = 250

print "STATUS: Starting sensor read/report loop"

def movingAvg(values,window):
	weights = np.repeat(1.0,window)/window
	smas = np.convolve(values,weights,'valid')
	return smas

while True:
	if connectedADC:
		if connectedIR:
			try:
				for i in range (0,10):
					infared = sensorADC.readADCSingleEnded(channelIR, gain, sps) # volts
			       		windowIR[i] = infrared
	
			except:
				print "ERROR: ADC - Infrared"
				infared = "NULL"
		if connectedUS:
			try:
				for i in range (0,10):
					ultrasonic = sensorADC.readADCSingleEnded(channelUS, gain, sps) # volts
			        windowUS[i] =  ultrasonic

			except:
				print "ERROR: ADC - Ultrasonic"
				ultrasonic = "NULL"

        IRAvg = movingAvg(windowIR,10)
        USAvg = movingAvg(windoUS,10)

	timestamp = datetime.datetime.now(timezone_eastern)

	### Temporary fix until posts to DB on server works
	f = open('/home/pi/sensor_data_log.txt', 'a')
	tempStr = "Timestamp: " + str(timestamp) + "\n"
	print tempStr
	f.write(tempStr)
	if connectedADC:
		tempStr = "ADS sensors:"
		if connectedIR:
			tempStr += "\nIR: %s" % IRAvg
		if connectedUS:
			tempStr += "\nUS: %s" % USAvg
		tempStr += "\n"
		print tempStr
		f.write(tempStr)
	tempStr = "\n"
	print tempStr
	f.write(tempStr)
	f.close()
	time.sleep(interval)


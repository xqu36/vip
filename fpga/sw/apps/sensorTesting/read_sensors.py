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

# User Configuration
interval = int(raw_input("How many seconds in between sensor reads?\t\tEnter an integer:\t"))
connectedRGB = bool(raw_input("Is the RGB sensor connected?\t\t\t\tEnter y or n:\t\t") == 'y')
connectedBMP = bool(raw_input("Is the pressure sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
connectedHTU = bool(raw_input("Is the humidity sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
connectedUV = bool(raw_input("Is the ultraviolet sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
connectedADC = bool(raw_input("Is the ADC connected to the I2C bus?\t\t\tEnter y or n:\t\t") == 'y')
if connectedADC:
	connectedIR = bool(raw_input("Is the infrared sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
	if connectedIR:
		channelIR = int(raw_input("What ADC channel is the IR sensor using?\t\tEnter 0, 1, 2, or 3:\t"))
	connectedUS = bool(raw_input("Is the ultrasonic sensor connected?\t\t\tEnter y or n:\t\t") == 'y')
	if connectedUS:
		channelUS = int(raw_input("What ADC channel is the ultrasonic sensor using?\tEnter 0, 1, 2, or 3:\t"))
	connectedCO = bool(raw_input("Is the carbon monoxide sensor connected?\t\tEnter y or n:\t\t") == 'y')
	if connectedCO:
		channelCO = int(raw_input("What ADC channel is the carbon monoxide sensor using?\tEnter 0, 1, 2, or 3:\t"))

# Set up sensors given by user
print "STATUS: Seting Up Sensors"
if connectedRGB:
	sensorRGB = TCS34725(integrationTime=0xEB, gain=0x01)
	sensorRGB.setInterrupt(False)
if connectedBMP:
	sensorBMP = BMP085.BMP085()
if connectedHTU:
	import HTU21DF as sensorHTU
if connectedUV:
	sensorUV = SI1145.SI1145()
if connectedADC:
	ADS1115 = 0x01 # chip identifier for ADC library
	sensorADC = ADS1x15(ic=ADS1115)
	gain = 4096
	sps = 250

print "STATUS: Starting sensor read/report loop"

while True:
	if connectedBMP:
		try:
			BMPtemperature = sensorBMP.read_temperature() # Pascals
			pressure = sensorBMP.read_pressure() # degrees Celcius
			altitude = sensorBMP.read_altitude() # meters
			sealevel_pressure = sensorBMP.read_sealevel_pressure() # Pascals
		except:
			print "ERROR: BPM180"
			BMPtemperature = "NULL"
			pressure = "NULL"
			altitude = "NULL"
			sealevel_pressure = "NULL"
	if connectedUV:
		try:
			uv = sensorUV.readUV() / 100.0 # UV index
			vis = sensorUV.readVisible() # Visible Light levels
			ir = sensorUV.readIR() # IR Light Levels
		except:
			print "ERROR: SI1145"
			uv = "NULL"
			vis = "NULL"
			ir = "NULL"
	if connectedRGB:
		try:
			rgb = sensorRGB.getRawData()
			red = rgb['r'] # units
			green = rgb['g'] # units
			blue = rgb['b'] # units
			color_temperature = sensorRGB.calculateColorTemperature(rgb) # degrees Kelvin
			illuminance = sensorRGB.calculateLux(rgb) # units
		except:
			print "ERROR: TCS34725"
			red = "NULL"
			green = "NULL"
			blue = "NULL"
			color_temperature = "NULL"
			illuminance = "NULL"

	if connectedHTU:
		try:
			sensorHTU.htu_reset
			HTUtemperature = sensorHTU.read_temperature()
			humidity = sensorHTU.read_humidity()
		except:
			print "ERROR: HTU21DF"
			HTUtemperature = "NULL"
			humidity = "NULL"
	if connectedADC:
		if connectedIR:
			try:
				infared = sensorADC.readADCSingleEnded(channelIR, gain, sps) # volts
			except:
				print "ERROR: ADC - Infrared"
				infared = "NULL"
		if connectedUS:
			try:
				ultrasonic = sensorADC.readADCSingleEnded(channelUS, gain, sps) #volts
			except:
				print "ERROR: ADC - Ultrasonic"
				ultrasonic = "NULL"
		if connectedCO:
			try:
				carbonMonoxide = sensorADC.readADCSingleEnded(channelCO, gain, sps) #volts
			except:
				print "ERROR: ADC - Carbon Monoxide"
				carbonMonoxide = "NULL"

	timestamp = datetime.datetime.now(timezone_eastern)

	### Temporary fix until posts to DB on server works
	f = open('/home/pi/sensor_data_log.txt', 'a')
	tempStr = "Timestamp: " + str(timestamp) + "\n"
	print tempStr
	f.write(tempStr)
	if connectedBMP:
		tempStr = "BMP sensors:\nT: {0}\nP: {1}\nA: {2}\nSLP: {3}\n".format(BMPtemperature, pressure, altitude, sealevel_pressure)
		print tempStr
		f.write(tempStr)
	if connectedUV:
		tempStr = "SI sensors:\nUV: {0}\nVis: {1}\nIR: {2}\n".format(uv, vis, ir)
		print tempStr
		f.write(tempStr)
	if connectedRGB:
		tempStr = "TCS sensors:\nR: %s\nG: %s\nB: %s\nCT: %s\nLux: %s\n" % (red, green, blue, color_temperature, illuminance)
		print tempStr
		f.write(tempStr)
	if connectedHTU:
		tempStr = "HTU sensors:\nT: %s\nH: %s\n" % (HTUtemperature, humidity)
		print tempStr
		f.write(tempStr)
	if connectedADC:
		tempStr = "ADS sensors:"
		if connectedIR:
			tempStr += "\nIR: %s" % infared
		if connectedUS:
			tempStr += "\nUS: %s" % ultrasonic
		if connectedCO:
			tempStr += "\nCO: %s" % carbonMonoxide
		tempStr += "\n"
		print tempStr
		f.write(tempStr)
	tempStr = "\n"
	print tempStr
	f.write(tempStr)
	f.close()
	time.sleep(interval)

import serial # import serial library 
import numpy # import numpy
import matplotlib.pyplot as plt #import matplotlib library
import time 
from drawnow import *

distA = [] 
arduinoData = serial.Serial('/dev/ttyACM0',9600) #create serial object
plt.ion() #interactive mode to plot live data
count=0
timeStamp = time.strftime("%d-%m-%Y_%H:%M:%S", time.localtime())
filename = 'ultrasonic_' + timeStamp + '.csv'
logfile=open(filename,'a')


def makeGraph(): #function that creates plot
	plt.ylim(0,1500)
	plt.title("Distance streaming (sample freq = 50Hz)")
	plt.grid(True)
	plt.ylabel("Distance (cm)")
	plt.xlabel("Sample")
	plt.plot(distA)


while True: 
	while (arduinoData.inWaiting()==0): #waits until there is data 
		pass # do nothing
	arduinoString = arduinoData.readline()  #read line from serial port
	a = "%s" % (arduinoString)
	logfile.write(a)
	logfile.flush()
	dist = int(arduinoString)              
	distA.append(dist)						#build dist array
	drawnow(makeGraph)                      #update live graph
	plt.pause(.00001)
	count=count+1
	if (count>100):         
		distA.pop(0)

logfile.close()
ser.close()
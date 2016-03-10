import serial # import serial library 
import time 
import csv

arduinoData = serial.Serial('/dev/ttyACM0',9600) #create serial object
timeStamp = time.strftime("%d-%m-%Y_%H:%M:%S", time.localtime())
filename = 'ultrasonic_' + timeStamp + '.csv'
logfile=open(filename,'a')

with open(filename + '.csv', 'w') as f:
	w = csv.writer(f)
	w.writerow(["timestamp","valid","sensor","data1"])
	arduinoString = arduinoData.readline()
	while True:
		sleep(1)
		if arduinoString is not None:
			row = [time(time),1,"ultrasonic",arduinoString]
			w.writerow(row)
	print "CSV file is ready"

logfile.close()
ser.close()
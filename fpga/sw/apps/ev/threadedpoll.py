import threading
import subprocess
import sys
import os
import signal
import atexit
import time
import datetime
from Adafruit_ADS1x15.Adafruit_ADS1x15 import ADS1x15 
import Adafruit_BMP.BMP085 as BMP085
import numpy as np
try:
    from cStringIO import StringIO
except:
    from StringIO import StringIO


# Initialize GPIO and I2C
subprocess.call(["/sbin/modprobe", "i2c-dev"])
time.sleep(3)

# Global Variables
ADS1115 = 0x01 # chip identifier for ADC library
sensorADC = ADS1x15(ic=ADS1115)
gain = 4096 # May have to change this
sps = 250 # May have to change this
sensor = BMP085.BMP085(busnum=1)

window = range(0,10)
windowIR=[0]*10
windowUS=[0]*10
windowCO=[0]*10

# Initialize Sensor Set
sensor_id = 3
interval = 0.25

global data
data = {}
mutex = threading.Lock()

# Utility Functions
def exitall(signal, frame):
  print "exiting"
  sys.exit(0)

def start_proc(cmd):
  process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  global child_pid
  child_pid = process.pid
  return process

def kill_child():
  if child_pid is None:
    pass
  else:
    try:
      os.kill(child_pid, signal.SIGINT)
    except OSError:
      print "Proc is already dead; killed by threads?"

def movingAvg(values,window): 
	weights = np.repeat(1.0,window)/window
	smas = np.convolve(values,weights,"valid")
	return smas

# Polling Threads 
def poll_proc(process):
  for line in iter(process.stdout.readline, ""):
    splitline = line.strip("\n").split(",")

    # put in dict here
    mutex.acquire()
    try:
      data["Calibration"]=splitline[0]
      data["Pedestrians"]=splitline[1]
      data["TotalPedestrians"]=splitline[2]
    finally:
      mutex.release()

def poll_sensors():
  while True:
    for i in window:
      windowIR[i] = sensorADC.readADCSingleEnded(0, gain, sps)
    for i in window:
	    windowUS[i] = sensorADC.readADCSingleEnded(1, gain, sps)
    for i in window:
      windowCO[i] = sensorADC.readADCSingleEnded(3, gain, sps)

    IRAvg = movingAvg(windowIR,10)
    USAvg = movingAvg(windowUS,10)
    COAvg = movingAvg(windowCO,10)

    Temp = sensor.read_temperature()
    Pressure = sensor.read_pressure()
    Altitude = sensor.read_altitude()
    Sealevel = sensor.read_sealevel_pressure()

    # put in dict here
    mutex.acquire()
    try:
      data["IRAvg"]=IRAvg
      data["USAvg"]=USAvg
      data["COAvg"]=COAvg
      data["Temp"]=Temp
      data["Pressure"]=Pressure
      data["Altitude"]=Altitude
      data["Sealevel"]=Sealevel
    finally:
      mutex.release()

    time.sleep(interval)
 
def main():
  #process = start_proc("/home/ubuntu/ev/segmentation")
  process = start_proc("./segmentation")
  atexit.register(kill_child)
  
  t1 = threading.Thread(target=poll_proc, args = (process,))
  t1.daemon = True
  t1.start()

  t2 = threading.Thread(target=poll_sensors)
  t2.daemon = True
  t2.start()

  #filename = time.strftime("%x").replace(" ","_")
  #print filename

  try:
    while True:
      print data
      time.sleep(1)
  except KeyboardInterrupt:
    print "Closing active threads..."
    t1.join()
    t2.join()

if __name__ == "__main__":
  signal.signal(signal.SIGTERM, exitall)
  main()

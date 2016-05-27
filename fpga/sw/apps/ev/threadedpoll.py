import threading
import subprocess
import sys
import os
import signal
import atexit
import time
import datetime
from Adafruit_ADS1x15.Adafruit_ADS1x15 import ADS1x15 
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

window = range(0,10)
windowIR=[0]*10
windowUS=[0]*10
windowPS=[0]*10
windowUV=[0]*10

# Initialize Sensor Set
sensor_id = 3
#interval = 0.25

# Utility Functions
def exitall(signal, frame):
  print "Took a 'kill [pid]' right to the face."
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
    os.kill(child_pid, signal.SIGINT)

def movingAvg(values,window): 
	weights = np.repeat(1.0,window)/window
	smas = np.convolve(values,weights,'valid')
	return smas

# Polling Threads 
def poll_proc(process):
  for line in iter(process.stdout.readline, ''):
    sys.stdout.write(line)
    # put in dict here

def poll_sensors():
  for i in window:
    windowIR[i] = sensorADC.readADCSingleEnded(0, gain, sps)
  for i in window:
	  windowUS[i] = sensorADC.readADCSingleEnded(1, gain, sps)
  for i in window:
    windowPS[i] = sensorADC.readADCSingleEnded(2, gain, sps)
  for i in window:
    windowUV[i] = sensorADC.readADCSingleEnded(3, gain, sps)

  IRAvg = movingAvg(windowIR,10)
  USAvg = movingAvg(windowUS,10)
  PSAvg = movingAvg(windowPS,10)
  UVAvg = movingAvg(windowUV,10)

  print "Infrared = %d ultrasonic = %d pressure = %d ultraviolet = %d" % (IRAvg, USAvg, PSAvg, UVAvg)

  # put in dict here

	#time.sleep(interval)
 
def main():
  process = start_proc("./segmentation")
  atexit.register(kill_child)
  
  t1 = threading.Thread(target=poll_proc, args = (process,)).start()
  t2 = threading.Thread(target=poll_sensors).start()

if __name__ == "__main__":
  signal.signal(signal.SIGTERM, exitall)
  main()

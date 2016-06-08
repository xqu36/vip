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
import pickle
import SSLClient
#from node_rsa import *

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

global data
data = {}

data_queue = []

WIFI_UP = True

mutex = threading.Lock()

# Utility Functions
def exitall(signal, frame):
  print "Exiting..."
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
      print "No such proc is running."

def movingAvg(values,window): 
	weights = np.repeat(1.0,window)/window
	smas = np.convolve(values,weights,"valid")
	return smas

# Polling Threads 
# report every .25s
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

# report every .5s
def poll_sensors_0():
  while True:
    #for i in window:
    #  windowIR[i] = sensorADC.readADCSingleEnded(0, gain, sps)
    #for i in window:
	  #  windowUS[i] = sensorADC.readADCSingleEnded(1, gain, sps)

    # the averager sleeps for 25ms, polls again, sleeps
    #for i in window:
    #  windowCO[i] = sensorADC.readADCSingleEnded(3, gain, sps)
    #  time.sleep(.025)

    #IRAvg = movingAvg(windowIR,10)
    #USAvg = movingAvg(windowUS,10)

    # data collected over .25s
    #COAvg = movingAvg(windowCO,10)
    COAvg = sensorADC.readADCSingleEnded(3, gain, sps)

    # put in dict here
    mutex.acquire()
    try:
      #data["IRAvg"]=IRAvg
      #data["USAvg"]=USAvg
      data["COAvg"]=COAvg
    finally:
      mutex.release()

    time.sleep(.5)

# report every 3m
def poll_sensors_1():
  while True:
    Temp = sensor.read_temperature()
    Pressure = sensor.read_pressure()
    #Altitude = sensor.read_altitude()
    #Sealevel = sensor.read_sealevel_pressure()

    # put in dict here
    mutex.acquire()
    try:
      data["Temp"]=Temp
      data["Pressure"]=Pressure
      #data["Altitude"]=Altitude
      #data["Sealevel"]=Sealevel
    finally:
      mutex.release()

    time.sleep(180)

def hold_data():
  # low-priority thread: does not need to perform @ real time
  # store recent data and keep a queue
  # upon losing wifi signal, store info in RAM to disk
  #
  # look for flag WIFI_UP=NO
  # write X number of packets, close file, encrypt
  #
  # write queue first, then iter

  global WIFI_UP
  written_queue = False
  writing = False

  while True:
    if(WIFI_UP == False):
      if(written_queue == False):
        qfilename = time.strftime("%c").replace(" ","_").replace(":","-")+"_queue.p"
        qfile = open(qfilename, "w")

        # Testing encryption
        #ctext = encrypt_data(data_queue)

        #pickle.dump(ctext, qfile)
        pickle.dump(data_queue, qfile)
        qfile.close()

        # TESTING
        #qfile = open(qfilename, "r")
        #picklecipher = pickle.load(qfile)
        #printfodder = decrypt_data(picklecipher)
        #print printfodder

        written_queue = True
      if(writing == False):
        pickle_queue = []
        pfilename = time.strftime("%c").replace(" ","_").replace(":","-")+".p"
        pfile = open(pfilename, "w")
        writing = True

      if(writing == True):
        pickle_queue.append(data)

        # encrypt and close data files every 5m
        if(len(pickle_queue) > 300):
          pickle.dump(pickle_queue, pfile)
          del pickle_queue[:]
          pfile.close()
          writing = False

    time.sleep(1)

 
def main():
  process = start_proc("/home/ubuntu/ev/segmentation")
  #process = start_proc("./segmentation")
  atexit.register(kill_child)
  
  t1 = threading.Thread(target=poll_proc, args=(process,))
  t1.daemon = True
  t1.start()

  t2 = threading.Thread(target=poll_sensors_0)
  t2.daemon = True
  t2.start()

  t3 = threading.Thread(target=poll_sensors_1)
  t3.daemon = True
  t3.start()

  t4 = threading.Thread(target=hold_data)
  t4.daemon = True
  t4.start()

  global WIFI_UP
  global data_queue

  try:
    while True:
      time.sleep(1)

      mutex.acquire()
      try:
        data["Timestamp"]=time.strftime("%c")
      finally:
        mutex.release()

      # enqueue most recent data
      data_queue.append(data)

      # keep the last 30s of data in RAM
      if(len(data_queue) > 30):
        del data_queue[0]

      # send packet
      try:
        SSLClient.send_data(data)
        WIFI_UP = True

      # on exception, set WIFI_UP flag and try again ad infinitum
      except socket.error:
        WIFI_UP = False
        continue

  except KeyboardInterrupt:
    # don't need to .join() threads when daemonized

if __name__ == "__main__":
  signal.signal(signal.SIGTERM, exitall)
  main()

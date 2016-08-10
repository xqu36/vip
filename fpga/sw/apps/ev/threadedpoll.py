#!/usr/bin/python
import threading
import subprocess
import sys
import os
import signal
import atexit
import time
import datetime
import math
import wave
import pyaudio
from Adafruit_ADS1x15.Adafruit_ADS1x15 import ADS1x15
import Adafruit_BMP.BMP085 as BMP085
import numpy as np
try:
  from cStringIO import StringIO
except:
  from StringIO import StringIO
import pickle
import SSLClient
import socket
from si1145 import read_ir
from si1145 import read_uv
from si1145 import read_vis
from si1145 import reset
from si1145 import calibration
import gps

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

TRANSMIT_INTERVAL = 3

mutex = threading.Lock()

# Utility Functions
def exitall(signal, frame):
  #print "Exiting..."
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
      pass

def start_gps():
  session = gps.gps("localhost", "2947")
  session.stream(gps.WATCH_ENABLE|gps.WATCH_NEWSTYLE)
  return session

def movingAvg(values,window):
  weights = np.repeat(1.0,window)/window
  smas = np.convolve(values,weights,"valid")
  return smas

# Polling Threads
# report every .25s
# EV
def poll_proc(process):
  for line in iter(process.stdout.readline, ""):
    splitline = line.strip("\n").split(",")

    # put in dict here
    mutex.acquire()
    try:
      #data["Calibration"]=splitline[0]
      if(len(splitline) == 3):
        data["CameraStatus"]=splitline[0]
        data["Pedestrians"]=splitline[1]
        data["TotalPedestrians"]=splitline[2]
      else:
        data["CameraStatus"]=splitline
    finally:
      mutex.release()

# report every 30s
# CO
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

    time.sleep(30)

# report every 3m
# Temp/Pressure
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

# audio
def poll_sensors_2():
  FORMAT = pyaudio.paInt16
  CHANNELS = 1
  RATE = 44100
  CHUNK = 1024
  RECORD_SECONDS = .125 #each recording is 1/8 sec long
  WAVE_OUTPUT_FILENAME = "file0.wav"
  audio = pyaudio.PyAudio()    #instantiate audio

  while True:
    try:
      stream = audio.open(format=FORMAT, channels=CHANNELS,
                    rate=RATE, input=True,
                    frames_per_buffer=CHUNK)

      frames = []

      for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
        datai = stream.read(CHUNK)
        frames.append(datai)

      stream.stop_stream()
      stream.close() #close the audio stream within the loop only to restart above

      #setting the parameters for the .WAV file

      #waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
      #waveFile.setnchannels(CHANNELS) #set channels
      #waveFile.setsampwidth(audio.get_sample_size(FORMAT))
      #waveFile.setframerate(RATE)
      #waveFile.writeframes(b''.join(frames))
      #waveFile.close()

      #Find the dB value
      #f = wave.open(WAVE_OUTPUT_FILENAME,'rb')
      #nchannels, sampwidth, framerate, nframes, comptype, compname = f.getparams()[:6]
      #byteList = np.fromstring(f.readframes(nframes), dtype = np.int16)
      #byteList = byteList.astype(np.float)
      #f.close()
      #avg = sum(byteList) / nframes #or len(byteList)
      #avg = sum(byteList) / len(byteList)
      #amp = abs(avg / 32767) #This is becase it is a 16 bit number (2^15 -1)
      #dB = 20 * math.log10(amp)

      byteList = np.fromstring(b''.join(frames), dtype = np.int16).astype(np.float)
      dat = byteList / 32768.0
      magSq = np.sum(dat ** 2.0) / len(dat)
      dB = 10.0 * math.log(magSq,10.0)


      mutex.acquire()
      try:
        data["dB"]=dB
      finally:
        mutex.release()
        time.sleep(3)

    except (IOError) as err:
      print "ruh roh error: {0}".format(err)
      data["dB"] = "NA"
      pass

  # close audio when thread dies
  audio.terminate()

# UV/IR/VIS
def poll_sensors_3():
  reset()
  calibration()
  while True:
    ir = read_ir()
    uv = read_uv()
    vis = read_vis()
    mutex.acquire()
    try:
      data["uv"]=uv
      data["ir"]=ir
      data["vis"]=vis
    finally:
  	  mutex.release()
  	  time.sleep(3)

# GPS
def poll_sensors_4(session):
  while True:
    try:
      report = session.next()

      # put in dict here
      mutex.acquire()

      try:
        if hasattr(report, 'lon'):
          data["Longitude"]=report.lon
        if hasattr(report, 'lat'):
          data["Latitude"]=report.lat
        if hasattr(report, 'alt'):
          data["Altitude"]=report.alt
      finally:
        mutex.release()

    except KeyError:
      pass
    except StopIteration:
      session = None

    time.sleep(3)


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
        #qfile = open(qfilename, "w")

        #pickle.dump(data_queue, qfile)
        #qfile.close()

        # Testing encryption
        #subprocess.call([ "openssl",
        #                  "rsautl",
        #                  "-encrypt",
        #                  "-pubin", "-inkey", "node1/public.pem"
        #                  "-in", qfilename,
        #                  "-out", qfilename+".enc" ])

        # TESTING
        #qfile = open(qfilename, "r")
        #printfodder = pickle.load(qfile)
        #print printfodder

        written_queue = True
      if(writing == False):
        pickle_queue = []
        pfilename = time.strftime("%c").replace(" ","_").replace(":","-")+".p"
        #pfile = open(pfilename, "w")
        writing = True

      if(writing == True):
        pickle_queue.append(data)

        # encrypt and close data files every 5m
        if(len(pickle_queue) > 300):
          #pickle.dump(pickle_queue, pfile)
          #del pickle_queue[:]
          #pfile.close()
          writing = False

          # Testing encryption
        #subprocess.call([ "openssl",
        #                  "rsautl",
        #                  "-encrypt",
        #                  "-pubin", "-inkey", "node1/public.pem"
        #                  "-in", pfilename,
        #                  "-out", pfilename+".enc" ])

    time.sleep(1)

def getUniqueIdentifier():
  try:
    fo = open("/etc/uniqsysidentity.conf")
    identity = fo.read(16)
    fo.close()
  except IOError:
    print "Error: Unable to open the Unique Identifier File! Who am I?"
    identity = "Invalid Identity"
  return identity



def main():
  dir_path = os.path.dirname(os.path.realpath(__file__))
  segmentation_path = str(dir_path) + "/segmentation"
  process = start_proc(segmentation_path)
  atexit.register(kill_child)

  session = start_gps()

  # EV's segmentation
  t1 = threading.Thread(target=poll_proc, args=(process,))
  t1.daemon = True
  t1.start()

  # COAvg
  t2 = threading.Thread(target=poll_sensors_0)
  t2.daemon = True
  t2.start()

  # Temp/Pressure
  t3 = threading.Thread(target=poll_sensors_1)
  t3.daemon = True
  t3.start()

  # Data caching
  t4 = threading.Thread(target=hold_data)
  t4.daemon = True
  t4.start()

  # Microphone
  t5 = threading.Thread(target=poll_sensors_2)
  t5.daemon = True
  t5.start()

  # UV/IR/VIS
  t6 = threading.Thread(target=poll_sensors_3)
  t6.daemon = True
  t6.start()

  # GPS
  t7 = threading.Thread(target=poll_sensors_4, args=(session,))
  t7.daemon = True
  t7.start()

  global WIFI_UP
  global data_queue
  global TRANSMIT_INTERVAL

  identity = getUniqueIdentifier()

  try:
    while True:
      time.sleep(TRANSMIT_INTERVAL)

      mutex.acquire()
      try:
        data["Timestamp"]=time.strftime("%c")
        data["Identifier"]=str(identity)
      finally:
        mutex.release()

      # enqueue most recent data
      data_queue.append(data)

      # keep the last 30s of data in RAM
      if(len(data_queue) > 30):
        del data_queue[0]

      # send packet
      try:
        print "Sending Data...."
        print data
        SSLClient.send_data(data, int(math.ceil(math.sqrt(TRANSMIT_INTERVAL))))
        WIFI_UP = True

      # on exception, set WIFI_UP flag and try again ad infinitum
      except socket.error as err:
        print "SSL Socket Error: {0}".format(err)
        WIFI_UP = False
        continue

  except KeyboardInterrupt:
    # don't need to .join() threads when daemonized
    pass

if __name__ == "__main__":
  signal.signal(signal.SIGTERM, exitall)
  main()

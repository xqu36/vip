#!/usr/bin/python
#import os
import SSLClient
import socket
import math
import time
import fcntl
import struct
import urllib2

devPack = {}

#Fcuntion for obtaining unique identifier.
def getUniqueIdentifier():
    try:
      fo = open("/etc/uniqsysidentity.conf")
      identity = fo.read(16)
      fo.close()
    except IOError:
      print "Error: Unable to open the Unique Identifier File! /etc/uniqsysidentity.conf Who am I?"
      identity = "Invalid Identity"
    return identity

#Function for obtaining local ip address.
def getIpAddr(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,
        struct.pack('256s', ifname[:15])
    )[20:24])



#Local IP set to locip
def sendPacket():
    uniqID = getUniqueIdentifier()
    devPack["Identity"] = str(uniqID)
    devPack["Timestamp"] = time.strftime("%c")
    devPack["Local IP"] =  getIpAddr('wlan0')
    print "Sending Data...."
    print devPack
    SSLClient.send_data(devPack)

def wifiSignal():
    try:
      host = socket.gethostbyname("techcities.vip.gatech.edu")
      s = socket.create_connection((host, 80),2)
      return False
    except:
      pass
    return True




noSignal = True
while noSignal:
    time.sleep(30)
    print "No WIFI signal, attempting to resend development packet..."
    noSignal = wifiSignal()


sendPacket()

#data = {}
#os.remove("sensor.log")

#!/usr/bin/python
#import os
import SSLClient
import socket
from itertools import islice
import math
import time

# break the dict into a list of dicts to send
def chunks(data, SIZE=10):
  it = iter(data)
  for i in xrange(0, len(data), SIZE):
    yield {k:data[k] for k in islice(it, SIZE)}

data = {}

#logfile = open("/home/ubuntu/ev/sensor.log", 'r')
logfile = open("sensor.log", 'r')

for line in logfile.readlines():
  splitline = line.strip("\n")

  # timestamp is 28 chars long
  timestamp = splitline[-28:]
  message = splitline[:-28]

  # put in dict here
  data[timestamp]=message

#idfile = open("/home/ubuntu/ev/id.log", 'r')
idfile = open("id.log", 'r')

for line in idfile.readlines():
  splitline = line.strip("\n")

chunksize = 10

dlen = len(data)
num_packets = int(math.ceil(float(dlen) / chunksize))

times = time.strftime("%a %b %d")
dictcount = 0

for item in chunks(data, chunksize):
  dictcount += 1
  item["HU_Index"]=str(dictcount) + "/" + str(num_packets)
  item["HealthUpdate"]=times
  item["NodeID"]=splitline
  SSLClient.send_data(item)

#os.remove("sensor.log")

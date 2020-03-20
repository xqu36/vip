#!/usr/bin/python 


import pprint
import socket  
import json
import ssl 
import pymongo 
from pymongo import MongoClient

client = MongoClient()
db = client.sensor_data
posts = db.posts

# Create a TCP/IP socket
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# bind the socket to a public host, and a well-known port
#serversocket.bind((socket.gethostname(), 443))
#serversocket.bind(("127.0.0.1", 10000))
try:
	serversocket.bind(("130.207.203.102", 50008))
# become a server socket
	serversocket.listen(5)
except socket.error, msg:
	print "Listen Failed: " + str(msg[0]) + msg[1]

def do_something(connstream, data):
    dictionary = json.loads(data)
    posts.insert_one(dictionary).inserted_id
    return False 

def deal_with_client(connstream):
    try:
        if connstream is None:
            print "NONE TYPE"
        data = connstream.read()
        while data:
            if not do_something(connstream, data):
                print "Successful Connection"
                #connstream.shutdown(socket.SHUT_RDWR)
                connstream.close()
                return
    except socket.error, msg:
        print "They slammed the TCP/IP phone on us! How rude!"
	print "Error message: " + str(msg[0]) + msg[1]
        #connstream.shutdown(socket.SHUT_RDWR)
        connstream.close()

def print_log(ssl_sock):
    print repr(ssl_sock.getpeername())
    print ssl_sock.cipher()
    print pprint.pformat(ssl_sock.getpeercert())


while True:
    newsocket, fromaddr = serversocket.accept()
    try:
    	connstream = ssl.wrap_socket(newsocket,
                                 server_side=True,
                                 certfile="smartcities/smartcities.pem",
                                 keyfile="smartcities/server.key",
                                 cert_reqs = ssl.CERT_REQUIRED,
                                 ca_certs="cacert.pem")
        deal_with_client(connstream)
    except socket.error, msg:
	if (msg != None):
		print "SSL wrap failed for server: " + str(msg[0]) + msg[1]
	err = 1
    finally:
	if connstream is not None:
	    connstream.close()
    #finally:	
        #deal_with_client(connstream)
    #except:
    #    print "fail"
	#raise

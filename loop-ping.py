#!/usr/bin/python
from subprocess import check_output
from subprocess import Popen
from subprocess import PIPE
import re

reg = re.compile('bytes from 10\.11\.1\.\d+')
output = []
outfile = open("/root/Research/respondingIPs2.txt", 'w')

for p in range(0,254):
   ip = "10.11.1." + str(p)
   output.append(Popen(["ping","-c","1",ip], stdout=PIPE))

for o in output:
   o.wait()
   for line in o.stdout:
      r = reg.search(line)
      if r:
         print(r.group().split()[2].strip())
         outfile.write(r.group().split()[2].strip() + '\n')

outfile.close()

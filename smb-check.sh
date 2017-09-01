#!/bin/bash

nmap -v -p 139,445 -oG ./temp.smb.txt 10.11.1.1-254 > /dev/nul

for ip in $(cat ./temp.smb.txt | grep open | cut -d " " -f 2); do
   echo $ip >&2
   nmap $ip --max-rtt-timeout 800ms --max-retries 3 --script smb-os-discovery.nse
done


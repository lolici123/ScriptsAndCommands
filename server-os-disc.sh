#!/bin/bash


if [ -z $1 ]; then
   echo "Error: Must supply IP input file"
   echo "Usage: Scripts/server-os-disc.sh IPs.txt"
   exit 1
fi
if [ ! -f $1 ]; then
   echo "Error: File $1 doesn't exist"
   exit 1
fi

echo "-------------------"
for ip in $(cat $1 | grep "Status: Up" | cut -d " " -f 2); do
   openIps=$(nmap -sV -p 80,443 $ip | grep "open")
   echo $ip
   if [ "$openIps" != "" ]; then
      echo "$openIps"
   fi
   nmap -O $ip | grep "OS" | grep -v -e "OS and Service" -e "OS detection performed"
   echo "-------------------"

done



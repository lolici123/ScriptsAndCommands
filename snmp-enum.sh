#!/bin/bash

IFS=$'\n'

for ip in $(cat tempIP.txt); do
   for mib in $(cat mib.txt); do
      echo $ip
      echo $mib | cut -d ":" -f 2
      snmpwalk -c public -v 1 $ip $(echo $mib | cut -d ":" -f 1 )
   done
done
unset IFS

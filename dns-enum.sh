#!/bin/bash

if [ -z $1 ]; then
   echo "Usage: ./dns-enum.sh domain.com"
   exit 1
fi

for ip in $(host -t ns $1 | cut -d " " -f 4); do
   host -l $1 $ip | grep "has address"
done

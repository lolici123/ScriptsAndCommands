#!/bin/bash
# Continusly pings Google every 60 sec to see if you are connected
# to the internet.  If not, it will document the downtime in the
# file 'offLineRecord.txt'


RECORD=false

while :; do
   LINE=$(ping -c 1 www.google.com 2>&1 | grep -oi "unknown host")
   if [ "$LINE" != 'unknown host' ]; then
      if [ "$RECORD" = true ]; then
         echo "TO" >> offLineRecord.txt
         date >> offLineRecord.txt
         RECORD=false
      fi
   else
      if [ "$RECORD" = false ]; then
         echo "" >> offLineRecord.txt
         date >> offLineRecord.txt
         RECORD=true
      fi
   fi
   sleep 60
done


#29790813 netgear case number



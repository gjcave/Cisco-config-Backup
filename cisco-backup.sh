#!/bin/bash


#Declare Cisco suffixes
ARRAY=( 'enta' 'entb' 'com01' 'com02' 'com03' 'adm01' 'adm02')
# get number of elements in the array
ELEMENTS=${#ARRAY[@]}


COUNT=$#
# Site Loop
for f in $@; do
#       nested loop for devices
        for (( i=0;i<$ELEMENTS;i++)); do
            IP=`dig +short  $f'-'${ARRAY[${i}]}'.lyondell.com'`
            if [ -n "$IP" ]; then
               echo $f'-'${ARRAY[${i}]}
               sshpass -f /home/gcave/.keys/lbpw scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no a_gxcave@$f'-'${ARRAY[${i}]}:system:running-config /home/gcave/tftp/router_switch/$f'-'${ARRAY[${i}]}
            fi
        done
   let COUNT=COUNT-1
      if [ $COUNT -gt 0 ]; then
             echo $COUNT "more site(s) to go"
      else
             echo "Backup Complete"
   fi
done
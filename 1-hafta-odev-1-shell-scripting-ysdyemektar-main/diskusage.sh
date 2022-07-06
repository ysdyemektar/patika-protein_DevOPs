#!/bin/bash
THRESOLD=8
EMAIL=yasadiyemektar730@gmail.com
#Part=yourdiskpart
PART=/boot
USE=`DF -H |GREP $part | awk '{print ½5}' | cut
if [$USE -gt $THRESHOLD ]; then
        echo "The partition "/dev/sda1" on bullseye has used 8% at and critical count=$var" at `date +%Y_%m_%d_%H:%M` |mail -s "Disk usage"
fi



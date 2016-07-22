#!/bin/bash

SHUTDOWN="$(cat /sys/class/gpio/gpio960/value)"
if [ $(cat /sys/class/gpio/gpio960/value) = 1 ]
then
    echo "Shutdown request stopped by sentinel script. $(date)" >> /home/ubuntu/ev/sensor.log
fi

echo $SHUTDOWN > /sys/class/gpio/gpio963/value


if [ $(cat /sys/class/gpio/gpio961/value) = 1 ]
then
    echo "Powering off for daily reset. $(date)" >> /home/ubuntu/ev/sensor.log 
    sudo poweroff
    
fi

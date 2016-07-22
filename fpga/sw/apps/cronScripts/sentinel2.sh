#!/bin/bash

# Health Check #
# Statement copies the value of gpio960 to gpio963. gpio960 is the output from
# the arduino health check statement, and gpio963 is the output from the FPGA
# to the arduino to cancel the health check reboot.
SHUTDOWN="$(cat /sys/class/gpio/gpio960/value)"
if [ $(cat /sys/class/gpio/gpio960/value) = 1 ]
then

    # Sensor log output.
    echo "Shutdown request stopped by sentinel script. $(date)" >> /home/ubuntu/ev/sensor.log
fi

echo $SHUTDOWN > /sys/class/gpio/gpio963/value


# Force Shutdown #
# If the force shutdown signal is recieved as a high value on gpio961
# the board writes to the sensor log and then powers off waiting
# for the power reset.
if [ $(cat /sys/class/gpio/gpio961/value) = 1 ]
then
    echo "Powering off for daily reset. $(date)" >> /home/ubuntu/ev/sensor.log 
    sudo poweroff
    
fi

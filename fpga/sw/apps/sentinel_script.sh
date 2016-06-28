#!/bin/bash 
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
TEMPFILE=/tmp/sentinal.tmp

set -x
#function for counter
function sensor_check {

    # Fetch the value and increase it
    COUNTER=$(( $(cat $TEMPFILE) + 1 ))

    #Check if we're unable to start too often
    if [ $COUNTER -eq 6 ]; then
        echo "Can't correctly launch script. Must reboot....$(date)" >> /home/ubuntu/ev/sensor.log
        sudo /sbin/reboot
        exit 0
    else
        echo $COUNTER > $TEMPFILE
        echo "num fails: "$COUNTER
    fi
}

#First time through, create the counter file
if [ ! -f $TEMPFILE ]; then
    touch $TEMPFILE
    echo 0 > $TEMPFILE
fi


#Check for internet connectivity
wget -q --spider http://smartcities.gatech.edu
if [ $? -eq 0 ]; then
	#Check for running process
	case "$(pgrep -f threadedpoll | wc -l)" in

	0)  /bin/echo "Starting Sensor Scripts...$(date)" >> /home/ubuntu/ev/sensor.log
	    # Fetch the value and increase it
	    sensor_check
	    /usr/bin/python /home/ubuntu/ev/threadedpoll.py &
	    ;;
	1)  #alls well. update sentinel timestamp and reset counter
	    touch $TEMPFILE
	    #echo 0 > $TEMPFILE
	    ;;
	*)  echo "Multiple sensor script instances running. No bueno....$(date)" >> /home/ubuntu/ev/sensor.log
	    kill $(pgrep -f threadedpoll)
	    sensor_check
	    ;;
	esac
else
	sensor_check
fi

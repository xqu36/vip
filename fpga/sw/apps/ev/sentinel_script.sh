#!/bin/bash

if [ -z $(CONSEC_FAILS) ] ; then
  CONSEC_FAILS=0
  export CONSEC_FAILS
fi

case "$(pgrep -f "python threadedpoll.py" | wc -w)" in

#start proc
0) /usr/bin/python /home/ubuntu/ev/threadedpoll.py &
  CONSEC_FAILS=$(CONSEC_FAILS)+1
  export CONSEC_FAILS
  ;;
1) #all good
  CONSEC_FAILS=0
  export CONSEC_FAILS
  ;;
*) kill $(pgrep -f "python threadedpoll.py" | awk '{print $1}')
  ;;
esac

if [ $(CONSEC_FAILS) -eq 5] ; then
  CONSEC_FAILS=0
  export CONSEC_FAILS
  reboot
fi

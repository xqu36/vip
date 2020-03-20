#!/bin/bash

# find unique identity
UNIQ=$(cat /etc/uniqsysidentity.conf)

# parse bytes and assign into new MAC
UMAC="00:0a:35:00:${UNIQ:2:2}:${UNIQ:4:2}"
echo $UMAC

# release IP
dhclient -r eth0

# assign MAC
ifconfig eth0 down
ifconfig eth0 hw ether $UMAC
ifconfig eth0 up

# reassign IP
dhclient eth0

#!/bin/sh

wpa_supplicant -qq -iwlan0 -c /etc/wpa_supplicant.conf & udhcpc -i wlan0

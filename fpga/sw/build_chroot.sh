

## Adding user information for rootfs ##
## Default password should be root ##
## unless prompted otherwise. ##
adduser --gecos "" ubuntu
addgroup ubuntu adm
addgroup ubuntu sudo
#addgroup ubuntu i2c
addgroup ubuntu audio
addgroup ubuntu video
addgroup ubuntu dialout
sudo chown -R ubuntu.ubuntu /home/ubuntu
rm /home/ubuntu/chroot.log


## Adding repositories and updating apt-get package manager ##
echo "deb http://ports.ubuntu.com/ trusty main restricted universe multiverse" > /etc/apt/sources.list
echo "deb http://ports.ubuntu.com/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ports.ubuntu.com/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ports.ubuntu.com/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
apt-get -y dist-upgrade >> /home/ubuntu/chroot.log
apt-get -y update >> /home/ubuntu/chroot.log
sudo apt-get -f install #fix broken dependencies (may need this for installing python-smbus)

## Packages for installation ##
## Add addtional packages here and list them on the wiki page ##
sudo apt-get -y install i2c-tools
sudo apt-get -y install python-dev
sudo apt-get -y install python-pip
sudo apt-get -y install ntp
sudo apt-get -y install ssh
sudo apt-get -y install numpy
sudo apt-get -y install etc
sudo apt-get -y install perl
sudo apt-get -y install wpasupplicant
sudo apt-get -y install linux-firmware
sudo apt-get -y install linux-firmware-nonfree
sudo apt-get -y install udhcpc
sudo apt-get -y install libopencv-dev
sudo apt-get -y install gpsd
sudo apt-get -y install python-GPS
sudo apt-get -y install usbutils
sudo apt-get -y install python-pyaudio
sudo apt-get -y install ntp

## Python libraries ##
## Add addtional libs here, and list them on the wiki page. ##
sudo pip install Adafruit_Libraries
#sudo pip install python-smbus
sudo apt-get -y install python-smbus
sudo apt-get -y install python-numpy

## Ownership changes. ##
sudo chown -R root.root /lib/modules/4.0.0-xilinx
# @jdanner3 additions
sudo chown -R ubuntu /home/ubuntu

## Install python libs ##
## Add new installation locations as needed. ##
cp -r /home/ubuntu/sensorTesting/Adafruit_ADS1x15 /home/ubuntu/ev
cp -r /home/ubuntu/sensorTesting/Adafruit_Python_BMP-master /home/ubuntu/ev
cd /home/ubuntu/sensorTesting/Adafruit_Python_BMP-master
sudo python setup.py install 

## Make segmentation and cleanup files. ##
cd /home/ubuntu/ev/
sudo make
rm *.cpp
rm *.hpp

addgroup ubuntu i2c
#(crontab -l 2>/dev/null; echo "* * * * * cd /home/ubuntu/cronScripts; /bin/bash /home/ubuntu/cronScripts/sentinel2.sh") | crontab -
echo "* * * * * ubuntu cd /home/ubuntu/ev; /bin/bash /home/ubuntu/cronScripts/sentinel2.sh" >> /etc/cron.d/healthMon
echo "@reboot ubuntu cd /home/ubuntu/ev; /bin/bash /home/ubuntu/cronScripts/devPacket.sh" >> /etc/cron.d/devPacket
echo "#* * * * * ubuntu cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/cronScripts/sentinel2.sh" >> etc/cron.d/healthMon
echo "#* * * * * ubuntu cd /home/ubuntu/ev; /bin/bash /home/ubuntu/cronScripts/sentinel_script.sh" >> /etc/cron.d/sentinel
echo "#* * * * * ubuntu cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/cronScripts/sentinel_scrpt.sh" >> /etc/cron.d/sentinel
echo "#30 5 * * * ubuntu cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/ev/health_update.sh" >> /etc/cron.d/healthUpdate
echo "#30 4 * * * ubuntu cd /mnt/ramdisk/apps; /bin/bash /mnt/ramdisk/apps/cronScripts/getSoftwareUpdate.sh" >> /etc/cron.d/softwareUpdate
echo "#30 4 * * * ubuntu cd /mnt/ramdisk/apps; /bin/bash /mnt/ramdisk/apps/cronScripts/updateChecker.sh" >> /etc/cron.d/firmwareUpdate
echo "ubuntu localhost = (root) NOPASSWD: /sbin/reboot" >> /etc/sudoers.d/reboot
echo "ubuntu localhost = (root) NOPASSWD: /sbin/poweroff" >> /etc/sudoers.d/poweroff
exit

echo "#####################"
echo "   EXITING CHROOT"
echo "#####################"
sleep 3
exit


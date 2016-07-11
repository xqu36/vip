

## Adding user information for rootfs ##
## Default password should be root ##
adduser --gecos "" ubuntu
#sudo passwd root ubuntu
addgroup ubuntu adm
addgroup ubuntu sudo
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
## Add addtional packages here and to the wiki page ##
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

## Python libraries ##
sudo pip install Adafruit_Libraries
#sudo pip install python-smbus
sudo apt-get -y install python-smbus
sudo apt-get -y install python-numpy

# @jdanner3 additions
#sudo chown -R ubuntu /home/ubuntu

# install python libs
cp -r /home/ubuntu/sensorTesting/Adafruit_ADS1x15 /home/ubuntu/ev
cp -r /home/ubuntu/sensorTesting/Adafruit_Python_BMP-master /home/ubuntu/ev
cd /home/ubuntu/sensorTesting/Adafruit_Python_BMP-master
sudo python setup.py install 

cd /home/ubuntu/ev/
sudo make
rm *.cpp
rm *.hpp

#sudo chown -R ubuntu /home/ubuntu
sudo chown -R root.root /lib/modules/4.0.0-xilinx
echo "#####################"
echo "   EXITING CHROOT"
echo "#####################"
sleep 3
exit


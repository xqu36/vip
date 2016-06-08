

## Adding user information for rootfs ##
## Default password should be root ##
adduser --gecos "" ubuntu
#sudo passwd root ubuntu
addgroup ubuntu adm
addgroup ubuntu sudo


## Adding repositories and updating apt-get package manager ##
echo "deb http://ports.ubuntu.com/ trusty main restricted universe multiverse" > /etc/apt/sources.list
echo "deb http://ports.ubuntu.com/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ports.ubuntu.com/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ports.ubuntu.com/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
apt-get -y dist-upgrade
apt-get -y update
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
sudo apt-get install usbutils
sudo apt-get install python-pyaudio

## Python libraries ##
sudo pip install Adafruit_Libraries
sudo pip install python-smbus
sudo apt-get -y install python-smbus
sudo apt-get -y install python-numpy

# @jdanner3 additions
cd /home/ubuntu/ev
make
cd -

echo "#####################"
echo "   EXITING CHROOT"
echo "#####################"
exit


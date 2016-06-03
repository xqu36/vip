## Variable Definitions ##

name=$USER
BUILDPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


###############################################
## FORMATING AND PARTITIONING OF SD CARD     ##
###############################################
## 		CURRENTLY UNUSED             ##
###############################################


##Check for parted, and Install parted if necessary.
#
#{
#if hash parted 2>/dev/null; then 
#	echo "parted Installed."
#else
#	sudo apt-get install parted
#
#fi 
#}
#
##Variable Definitions
#export OutputDev=sdb
#Answer=n
#
##Devices
#df -Th
#read -p "Device to be formated? " OutputDev
#echo "Seleced Device:" $OutputDev
#read -p "Is this choice correct? [Y/n] " Answer
#if [[$Answer = [Yy]];then
#echo "Formatting " $OutputDev

##Unmount Device
#sudo umount /dev/"$OutputDev"
#sudo parted /dev/"$OutputDev" print
#sudo parted "$@"


###########################################################
##       DOWNLOADING AND INSTALLING UBUNTU CORE FS       ##
###########################################################



## Download Ubuntu Core ##
# sudo wget -cv "cdimage.ubuntu.com/ubuntu-core/releases/14.04.3/release/ubuntu-core-14.04.3-core-armhf.tar.gz"

## Copy file to the SD card ##
# sudo cp ubuntu-core-14.04.3-core-armhf.tar.gz /media/$name/rootfs/
# sudo rm ubuntu-core-14.04.3-core-armhf.tar.gz

## Change directoy to SD card and unpackage the rootfs ##
cd /media/$name/rootfs/
sudo tar -xzpvf ubuntu-core-14.04.3-core-armhf.tar.gz

## Append and add needed files for accessing the baoard through UART ##
cd etc/security/
sudo chmod a=rw access.conf
echo "# Zynq's UARTs" >> access.conf
echo "ttyPS0" >> access.conf
echo "ttyPS1" >> access.conf

cd ../init/
sudo touch ttyPS0.conf
sudo chmod a=rw ttyPS0.conf
echo "# ttyPS0 - getty" > ttyPS0.conf
echo "#" >> ttyPS0.conf
echo "# This service maintains a getty on ttyPS0 from the point the system is" >> ttyPS0.conf
echo "#started until it is shut down again." >> ttyPS0.conf
echo "" >> ttyPS0.conf
echo "start on stopped rc RUNLEVEL=[2345] and (" >> ttyPS0.conf
echo "not-container or" >> ttyPS0.conf
echo "container CONTAINER=lxc or" >> ttyPS0.conf
echo "container CONTAINER=lxc-libvirt)" >> ttyPS0.conf
echo "" >> ttyPS0.conf
echo "stop on runlevel [!2345]" >> ttyPS0.conf
echo "" >> ttyPS0.conf
echo "respawn" >> ttyPS0.conf
echo "exec /sbin/getty -L -8 115200 ttyPS0" >> ttyPS0.conf

## Adding Xilinx modules to rootfs ##
sudo mkdir ../../lib/modules
sudo cp -r $BUILDPATH/petalinux/zedboard-baseline/build/linux/rootfs/targetroot/lib/modules/4.0.0-xilinx/ ../../lib/modules/4.0.0-xilinx


####################################################################
## PREPARING THE ROOTFS FOR DISTRIBUTION WITH PROJECT INFORMATION ##
####################################################################
## Copying all project specific files from the /sw/apps folder ##
sudo rsync -r --exclude=modules $BUILDPATH/apps/ /media/$name/rootfs/home/ubuntu

## chroot into the rootfs and running the build_chroot.sh script ##
## Any commands to be run from chroot should be added to build_chroot.sh ##

sudo apt-get install qemu-user-static
cd /media/$name/rootfs/
echo "###################"
echo "  ENTERING CHROOT"
echo "###################"
sudo chmod +x $BUILDPATH/build_chroot.sh
sudo cp $BUILDPATH/build_chroot.sh /media/$name/rootfs/
sudo cp /usr/bin/qemu-arm-static usr/bin/
sudo mv etc/resolv.conf etc/resolv.conf.saved
sudo cp /etc/resolv.conf etc/resolv.conf
for m in `echo 'sys dev proc'`; do sudo mount /$m ./$m -o bind; done
sudo LC_ALL=C chroot . /bin/bash -c "./build_chroot.sh"

for m in `echo 'sys dev proc'`; do sudo umount ./$m; done
sudo mv etc/resolv.conf.saved etc/resolv.conf

sudo rm /media/$name/rootfs/build_chroot.sh
sudo mkdir /media/$name/rootfs/lib/firmware
sudo mkdir /media/$name/rootfs/lib/firmware/rtlwifi
sudo cp $BUILDPATH/apps/modules/rtl8192cufw_TMSC.bin /media/$name/rootfs/lib/firmware/rtlwifi
cd /media/$name/rootfs/home/ubuntu/sensorTesting/Adafruit_Python_BMP-master
sudo python setup.py install

sudo cp $BUILDPATH/apps/modules/interfaces /media/$name/rootfs/etc/network/
sudo cp $BUILDPATH/apps/modules/wpa_supplicant.conf /media/$name/rootfs/etc/



echo "END OF BUILD SCRIPT"

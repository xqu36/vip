#!/bin/bash

# Chris Turner
# cturner48@gatech.edu
#
# Script for automating the build process of the GaTech Embedded Systems
# VIP rootfs. Completes all necessary setup for the development phase
# of the project. Requires that the SD card be formatted with the
# BOOT/rootfs partitions as outlined on the team wiki. Will need to 
# provide mount location of the rootfs partition.


## To add new software packages refer to build_chroot.sh. ##
## Variable Definitions ##
RFSLOC=0
CLEAN=0
VERBOSE=0
BUILDPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


function usage() {
    echo "Usage: build_rootfs.sh -t=[SD mount location] [options]"
    echo -e "\t -t|--target: Must provide full mount address of the rootfs SD card partition."
    echo -e "\t -v|--verbose: Enables verbose mode. [Default 0]"
   # echo -e "\t -c|--clean: Erases all files on the SD card, and downloads a new copy of the ubuntu core tar."
    echo -e "\t -h|--help: Show help information. Hint: You're lookin' at it!"
}

## For loop to check for arguments and assign variables. ##
for i in "$@"
do
case $i in 
    -t=*|--target=*)
    RFSLOC="${i#*=}"
    shift
    ;;
    -v|--verbose)
    VERBOSE=1
    shift
    ;;
    -c|--clean)
    CLEAN=1
    shift
    ;;
    -h|--help)
    usage
    exit 1
    ;;
    *)
    echo "Unkown option $i, now exiting build script."
    exit 1
    ;;
esac
done

echo "##################################"
echo "##        BUILDING ROOTFS       ##"
echo "##################################"

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
cd $RFSLOC
if [ "$VERBOSE" -eq 1 ]
then
    echo "Unpacking Ubuntu Core FS on SD card..."
    tar -xzpvf ubuntu-core-14.04.3-core-armhf.tar.gz
else
    echo "Unpacking Ubuntu Core FS on SD card..."
    tar -xzpf ubuntu-core-14.04.3-core-armhf.tar.gz
fi

## Append and add needed files for accessing the board through UART ##

if [ "$VERBOSE" -eq 1 ]
then
    echo "Editing access configuration to include serial ports..."
fi

## Creating access.conf ##
cd $RFSLOC/etc/security/
chmod a=rw access.conf
echo "# Zynq's UARTs" >> access.conf
echo "ttyPS0" >> access.conf
echo "ttyPS1" >> access.conf

if [ "$VERBOSE" -eq 1 ]
then
    echo "Editing serial 0 configuration for terminal access..."
fi

## Creating ttyPS0.conf ##
cd ../init/
touch ttyPS0.conf
chmod a=rw ttyPS0.conf
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
if [ "$VERBOSE" -eq 1 ]
then
    echo "Unpacking xilinx modules..."
    mkdir $RFSLOC/lib/modules
    tar xzvf $BUILDPATH/apps/setup/modules/4.0.0-xilinx.tar.gz -C $RFSLOC/lib/modules/
else
    echo "Unpacking xilinx modules..."
    mkdir $RFSLOC/lib/modules
    tar xzf $BUILDPATH/apps/setup/modules/4.0.0-xilinx.tar.gz -C $RFSLOC/lib/modules/
fi

####################################################################
## PREPARING THE ROOTFS FOR DEVELOPMENT WITH PROJECT INFORMATION  ##
####################################################################


##  Copying all project specific files from the /sw/apps folder excluding setup   ##
if [ "$VERBOSE" -eq 1 ]
then
    echo "Copying all project specific files to rootfs..."
    echo "All files located under the $BUILDPATH/apps folder are included except the setup folder."
fi


rsync -r --exclude=setup $BUILDPATH/apps/ $RFSLOC/home/ubuntu
cp $BUILDPATH/apps/setup/modules/rc.local $RFSLOC/etc/.
cp $BUILDPATH/apps/setup/modules/interfaces $RFSLOC/etc/network/.
cp $BUILDPATH/apps/setup/modules/wpa_supplicant.conf $RFSLOC/etc/.
cp $BUILDPATH/apps/setup/modules/failsafe.conf $RFSLOC/etc/init/.
cp $BUILDPATH/apps/setup/modules/.bashrc $RFSLOC/home/ubuntu/.


## chroot into the rootfs and running the build_chroot.sh script ##
## Any commands to be run from chroot should be added to build_chroot.sh ##
## To add new software packages refer to build_chroot.sh. ##
apt-get install qemu-user-static
cd $RFSLOC 
echo "###################"
echo "# ENTERING CHROOT #"
echo "###################"

if [ "$VERBOSE" -eq 1 ]
then
    echo "Running build_chroot.sh..."
fi

chmod +x $BUILDPATH/build_chroot.sh
cp $BUILDPATH/build_chroot.sh $RFSLOC 
cp /usr/bin/qemu-arm-static usr/bin/
mv etc/resolv.conf etc/resolv.conf.saved
cp /etc/resolv.conf etc/resolv.conf
for m in `echo 'sys dev proc'`; do sudo mount /$m ./$m -o bind; done
LC_ALL=C chroot . /bin/bash -c "./build_chroot.sh"

if [ "$VERBOSE" -eq 1 ]
then
    echo "Leaving chroot and performing cleanup..."
fi

sleep 3
for m in `echo 'sys dev proc'`; do sudo umount ./$m; done
mv etc/resolv.conf.saved etc/resolv.conf

rm $RFSLOC/build_chroot.sh
(crontab -l 2>/dev/null; echo "* * * * * cd /home/ubuntu; /bin/bash /home/ubuntu/cronScripts/sentinel2.sh") | crontab -

echo "#######################"
echo "# END OF BUILD SCRIPT #"
echo "#######################"

#!/bin/bash

# Jay Danner
# 1/11/2016
#
# build.sh combines all the build processes inherent to this project into one easy to use script.
# This builds hardware/block design, OS, drivers, apps, IP modules, keys, and bootable images all in one.
#
# Help/usage is found below.

# Variables / cmd line args

# default
TARGETS=all
HWPATH=../hw/
SWPATH=

for i in "$@"
do 
case $i in
    -t=*|--targets=*)
    TARGETS="${i#*=}"
    shift
    ;;
    -hp=*|--hwpath=*)
    HWPATH="${i#*=}"
    shift
    ;;
    -sp=*|--swpath=*)
    SWPATH="${i#*=}"
    shift
    ;;
    -c|--clean)
    CLEAN=YES
    shift
    ;;
    *)
    echo "Unknown option $i, exiting"
    exit 1
    ;;
esac
done

# Process TARGETS
IFS=","

if [ $TARGETS==all ] && [ ${#TARGETS}==1 ]
then
    TARGETS=hw,sw,hls,boot,key
fi

for a in $TARGETS
do
case $a in
    hw)

    ############
    # Build HW #
    ############

    # run vivado
    setup_vivado14
    vivado -mode tcl -source $HWPATH/build.tcl -notrace
    # source tcl
    # integrate IP

    ;;

    sw)

    ############
    # Build SW #
    ############
    echo "running sw"    
    
    # clean petalinux
    # build petalinux
    # build apps
    # build drivers
    # create boot image

    ;;

    hls)

    #############
    # Build HLS #
    #############
    echo "running hls"    
    
    # run vivado_hls
    # run csim
    # run synthesis
    # package IP

    ;;

    boot)

    #########################################
    #           Package Bootables           #
    # (Baby that's what makes you bootable) #
    #########################################
    
    echo "running boot"    
    # petalinux-package

    ;;

    key)

    ##############
    # Build keys #
    ##############

    echo "running keys"    
    # generate keys

    ;;

    all)
    echo "skip all"
    ;;

    *)
    echo "Available targets: hw, sw, hls, boot, key, all. Exiting..."
    exit 1
    ;;
esac

#########
# Clean #
#########

# warning
# delete project folders
# clean HLS products
# clean petalinux

done

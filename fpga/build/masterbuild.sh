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
CLEAN=0
VERBOSE=0
HWPATH=../hw
SWPATH=../sw
HLSPATH=../hw/src/hls

PROJNAME=zedboard-baseline

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
    -hlsp=*|--hlspath=*)
    HLSPATH="${i#*=}"
    shift
    ;;
    -c|--clean)
    CLEAN=1
    shift
    ;;
    -v|--verbose)
    VERBOSE=1
    shift
    ;;
    *)
    echo "Unknown option $i, exiting"
    exit 1
    ;;
esac
done

#########
# BUILD #
#########

IFS=","
TGTARRAY=( $TARGETS )

if [ ${#TGTARRAY[@]} -eq 1 ]
then
    if [ "$TARGETS" == "all" ]
    then
        TARGETS=hw,sw,hls,boot,key
    fi
fi

echo "TARGETS: $TARGETS"
echo "CLEAN: $CLEAN"
echo "VERBOSE: $VERBOSE"

for a in $TARGETS
do
case $a in
    hw)

    ############
    # Build HW #
    ############

    if [ "$VERBOSE" -eq 1 ]
    then
        echo "Building HW..."
    fi

    # clean
    if [ "$CLEAN" -eq 1 ]
    then
        if [ -d "$HWPATH/project" ]
        then
            echo "rm -rf $HWPATH/project"
            rm -rf $HWPATH/project
        fi
    fi

    # check if project directory already exists
    # NOTE: project name "project" is defined in HWPATH/build.tcl
    if [ -d "$HWPATH/project" ]
    then
        echo "Project directory $HWPATH/project already exists. Include -c|--clean if you want to rebuild."
    else
        # run vivado & source tcl
        echo "Starting Vivado in tcl mode."

        source /opt/Xilinx/Vivado/2014.4/settings64.sh
        vivado -mode batch -source $HWPATH/build.tcl -notrace -nolog -nojournal

        echo "HW build done!"
    fi
    ;;

    sw)

    ############
    # Build SW #
    ############

    if [ $VERBOSE -eq 1 ]
    then
        echo "Building SW..."    
        echo "NOTE: HW must be built first!"
    fi

    # clean
    if [ $CLEAN -eq 1 ]
    then
        echo "petalinux-build -p $SWPATH/petalinux/$PROJNAME -x mrproper"
        petalinux-build -p $SWPATH/petalinux/$PROJNAME/ -x mrproper
    fi
    
    # get hw description & config
    petalinux-config -p $SWPATH/petalinux/$PROJNAME --get-hw-description=$HWPATH/project/zedboard_baseline.sdk/
    petalinux-build -p $SWPATH/petalinux/$PROJNAME

    # build apps
    # build drivers

    ;;

    hls)

    #############
    # Build HLS #
    #############
    echo "Building HLS..."    
    
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
    
    if [ $VERBOSE -eq 1 ]
    then
        echo "Packaging boot images..."
        echo "NOTE: HW & SW need to be built first!"
    fi

    # petalinux-package

    ;;

    key)

    ##############
    # Build keys #
    ##############

    echo "running keys"    
    # generate keys

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

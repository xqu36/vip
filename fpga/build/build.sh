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
SECURE=0
BIF=boot_test

BUILDPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HWPATH=$BUILDPATH/../hw
SWPATH=$BUILDPATH/../sw
HLSPATH=$BUILDPATH/../hw/src/hls

# petalinux project name
PROJNAME=zedboard-baseline

function usage() {
    echo "Usage: build.sh -t[=all] [optional args]"
    echo -e "\t -t|--targets: Available targets are key, hls, hw, sw, boot (or all). Targets must be run in this order. [Default all]"
    echo -e "\t -c|--clean: Clean specified targets before building. [Default 0]"
    echo -e "\t -v|--verbose: Enables verbose mode. [Default 0]"
    echo -e "\t -hp|--hwpath: Path to /hw/. [Default fpga/hw]"
    echo -e "\t -sp|--swpath: Path to /sw/. [Default fpga/sw]"
    echo -e "\t -hlsp|--hlspath: Path to /hls/. [Default fpga/hw/src/hls]"
    echo -e "\t -h|--help: Display this menu."
    echo -e "\t -s|--secure: build with secure boot functionality [defaults to non-secure]"
    echo "NOTE: Petalinux settings must be sourced from your ~/.bashrc script, not from build.sh."
}

# Set up the most recent Vivado and the SDK
if [ -d "/opt/Xilinx/Vivado/2014.4" ]
then
    source /opt/Xilinx/Vivado/2014.4/settings64.sh
    source /opt/Xilinx/SDK/2014.4/settings64.sh
    echo "INFO: Using the 2014.4 Xilinx tools"
fi
if [ -d "/opt/Xilinx/Vivado/2015.4" ]
then
    source /opt/Xilinx/Vivado/2015.4/settings64.sh
    source /opt/Xilinx/SDK/2015.4/settings64.sh
    echo "INFO: Using the 2015.4 Xilinx tools"
fi

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
    -h|--help)
    usage
    exit 1
    ;;
    -s|--secure)
    SECURE=1
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
        # NOTE: correct order below
        TARGETS=key,hls,hw,sw,boot
    fi
fi

echo "Starting build script..."
echo ""

if [ "$VERBOSE" -eq 1 ]
then
    echo "TARGETS: $TARGETS"
    echo "BUILDPATH: $BUILDPATH"
    echo "HWPATH: $HWPATH"
    echo "SWPATH: $SWPATH"
    echo "HLSPATH: $HLSPATH"
    
fi

for a in $TARGETS
do
case $a in
    key)

    ##############
    # Build keys #
    ##############

    if [ $VERBOSE -eq 1 ]
    then
        echo ""
        echo "----------------------------"
        echo "| Generating bitstream key |"
        echo "----------------------------"
        echo ""
    fi

    # clean
    if [ "$CLEAN" -eq 1 ]
    then
        if [ -f "$BUILDPATH/keygen/keyfile.nky" ]
        then
            echo "rm $BUILDPATH/keygen/keyfile.nky"
            rm $BUILDPATH/keygen/keyfile.nky
        fi
    fi

    # generate keys
    echo "$BUILDPATH/keygen/xilinx_keyfile_generator.sh"
    $BUILDPATH/keygen/xilinx_keyfile_generator.sh

    echo "Output keyfile.nky in $BUILDPATH/keygen"

    ;;

    hw)

    ############
    # Build HW #
    ############

    if [ "$VERBOSE" -eq 1 ]
    then
        echo ""
        echo "------------------"
        echo "| Building HW... |"    
        echo "------------------"
        echo "NOTE: Keygen must be built first!"
        echo ""
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
        echo ""
        echo "------------------"
        echo "| Building SW... |"    
        echo "------------------"
        echo "NOTE: HW must be built first!"
        echo ""
    fi

    # clean
    if [ $CLEAN -eq 1 ]
    then
        echo "petalinux-build -p $SWPATH/petalinux/$PROJNAME -x mrproper"
        petalinux-build -p $SWPATH/petalinux/$PROJNAME/ -x mrproper 
    fi
    
    if [ ! -d "$SWPATH/petalinux/$PROJNAME/build" ]
    then
	# regenerate first stage bootloader for hardware
#	hsi -mode batch -source $BUILDPATH/support/generate_fsbl.tcl -tclargs $HWPATH/project/zedboard_baseline.sdk/zedboard_baseline.hdf 
        # get hw description & config
        petalinux-config -p $SWPATH/petalinux/$PROJNAME --get-hw-description=$HWPATH/project/zedboard_baseline.sdk/
        petalinux-build -p $SWPATH/petalinux/$PROJNAME
    else
        echo "$SWPATH/petalinux/$PROJNAME/build already exists. Include -c|--clean if you want to rebuild."
    fi

    # build apps
    # build drivers

    ;;

    hls)

    #############
    # Build HLS #
    #############

    if [ $VERBOSE -eq 1 ]
    then
        echo ""
        echo "-------------------"
        echo "| Building HLS... |"    
        echo "-------------------"
        echo ""
    fi
    
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
        echo ""
        echo "----------------------------"
        echo "| Packaging boot images... |"
        echo "----------------------------"
        echo "NOTE: HW & SW need to be built first!"
        echo ""
    fi

    if [ $CLEAN -eq 1 ]
    then
        if [ -d "$BUILDPATH/boot" ]
        then
            echo "rm -rf $BUILDPATH/boot"
            rm -rf $BUILDPATH/boot
        fi

        if [ -f "$BUILDPATH/BOOT.BIN" ]
        then
            rm $BUILDPATH/BOOT.BIN
        fi
    fi

    if [ ! -d "$BUILDPATH/boot" ]
    then
        mkdir $BUILDPATH/boot
    fi 

    echo "cp $SWPATH/petalinux/$PROJNAME/subsystems/linux/hw-description/zedboard_baseline_wrapper.bit $SWPATH/mkboot/"
    cp $SWPATH/petalinux/$PROJNAME/subsystems/linux/hw-description/zedboard_baseline_wrapper.bit $SWPATH/mkboot/

    # Let's make a copy of the key for a local reference from the .bif file
    cp $BUILDPATH/keygen/keyfile.nky $SWPATH/mkboot/keyfile.nky
    echo "cp $BUILDPATH/keygen/keyfile.nky $SWPATH/mkboot/keyfile.nky"

    # $SWPATH/mkboot has all the files it needs (keyfile, bitstream, FSBL, and U-Boot) so let's package it up
    # BootGen gets confused with .bif references
    cd $SWPATH/mkboot
    # Is this a secure build?
    if [ $SECURE -eq 1 ]
    then
        BIF=boot_secure
        KEYLOCATION="-encrypt bbram"
    fi
    # Verbose?
    if [ $VERBOSE -eq 1 ]
    then
        bootgen $KEYLOCATION -image $SWPATH/mkboot/$BIF.bif -o $BUILDPATH/boot/BOOT.bin -w on -debug
        echo "bootgen $KEYLOCATION -image $SWPATH/mkboot/$BIF.bif -o $BUILDPATH/boot/BOOT.bin -w on -debug"
    else
        bootgen $KEYLOCATION -image $SWPATH/mkboot/$BIF.bif -o $BUILDPATH/boot/BOOT.bin -w on
        echo "bootgen $KEYLOCATION -image $SWPATH/mkboot/$BIF.bif -o $BUILDPATH/boot/BOOT.bin -w on"
    fi
    cd $BUILDPATH

    # Leaving keys lying around is bad
    if [ -f "$SWPATH/mkboot/keyfile.nky" ]
    then
        echo "Removing temporary keyfile: rm $SWPATH/mkboot/keyfile.nky"
        rm $SWPATH/mkboot/keyfile.nky
    fi
    echo "cp $SWPATH/petalinux/$PROJNAME/images/image.ub $BUILDPATH/boot"
    cp $SWPATH/petalinux/$PROJNAME/images/linux/image.ub $BUILDPATH/boot

    if [ -f "$BUILDPATH/BOOT.bin" ]
    then
        echo "mv $BUILDPATH/BOOT.bin $BUILDPATH/boot/"
        mv $BUILDPATH/BOOT.BIN $BUILDPATH/boot/
    fi

    ;;

    *)
    echo "Available targets: hw, sw, hls, boot, key, all. Exiting..."
    exit 1
    ;;
esac

done

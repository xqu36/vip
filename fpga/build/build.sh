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
    echo "NOTE: Petalinux settings must be sourced from your ~/.bashrc script, not from build.sh."
}

# machine-dependent
source /opt/Xilinx/Vivado/2014.4/settings64.sh
source /opt/Xilinx/SDK/2014.4/settings64.sh
#source /opt/pkg/petalinux-v2014.4-final/settings.sh

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
        if [ -f "$BUILDPATH/keygen/dummy_key.nky" ]
        then
            echo "rm $BUILDPATH/keygen/dummy_key.nky"
            rm $BUILDPATH/keygen/dummy_key.nky 
        fi
    fi

    # generate keys
    echo "$BUILDPATH/keygen/xilinx_keyfile_generator.sh"
    $BUILDPATH/keygen/xilinx_keyfile_generator.sh

    echo "Output dummy_key.nky in $BUILDPATH/keygen"

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
        echo "petalinux-build -p $SWPATH/petalinux/$PROJNAME -x distclean"
        petalinux-build -p $SWPATH/petalinux/$PROJNAME/ -x distclean
    fi
    
    if [ ! -d "$SWPATH/petalinux/$PROJNAME/build" ]
    then
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

    echo "cp $SWPATH/petalinux/$PROJNAME/images/image.ub $BUILDPATH/boot"
    cp $SWPATH/petalinux/$PROJNAME/images/linux/image.ub $BUILDPATH/boot

    echo "petalinux-package --boot --fsbl $SWPATH/mkboot/zynq_fsbl.elf --fpga $SWPATH/mkboot/zedboard_baseline_wrapper.bit --u-boot=$SWPATH/mkboot/u-boot.elf --force"
    petalinux-package -p $SWPATH/petalinux/$PROJNAME --boot --fsbl $SWPATH/mkboot/zynq_fsbl.elf --fpga $SWPATH/mkboot/zedboard_baseline_wrapper.bit --u-boot=$SWPATH/mkboot/u-boot.elf --force

    if [ -f "$BUILDPATH/BOOT.BIN" ]
    then
        echo "mv $BUILDPATH/BOOT.BIN $BUILDPATH/boot/"
        mv $BUILDPATH/BOOT.BIN $BUILDPATH/boot/
    fi

    ;;

    *)
    echo "Available targets: hw, sw, hls, boot, key, all. Exiting..."
    exit 1
    ;;
esac

done

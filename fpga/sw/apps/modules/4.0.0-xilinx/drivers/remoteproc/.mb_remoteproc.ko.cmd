cmd_drivers/remoteproc/mb_remoteproc.ko := arm-xilinx-linux-gnueabi-ld -EL -r  -T /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/scripts/module-common.lds --build-id  -o drivers/remoteproc/mb_remoteproc.ko drivers/remoteproc/mb_remoteproc.o drivers/remoteproc/mb_remoteproc.mod.o
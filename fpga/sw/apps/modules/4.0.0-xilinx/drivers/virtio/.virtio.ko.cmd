cmd_drivers/virtio/virtio.ko := arm-xilinx-linux-gnueabi-ld -EL -r  -T /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/scripts/module-common.lds --build-id  -o drivers/virtio/virtio.ko drivers/virtio/virtio.o drivers/virtio/virtio.mod.o

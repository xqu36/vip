cmd_net/ipv4/ip_tunnel.ko := arm-xilinx-linux-gnueabi-ld -EL -r  -T /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/scripts/module-common.lds --build-id  -o net/ipv4/ip_tunnel.ko net/ipv4/ip_tunnel.o net/ipv4/ip_tunnel.mod.o
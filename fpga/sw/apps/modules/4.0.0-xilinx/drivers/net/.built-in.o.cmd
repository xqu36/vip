cmd_drivers/net/built-in.o :=  arm-xilinx-linux-gnueabi-ld -EL    -r -o drivers/net/built-in.o drivers/net/mii.o drivers/net/Space.o drivers/net/loopback.o drivers/net/netconsole.o drivers/net/phy/built-in.o drivers/net/can/built-in.o drivers/net/ethernet/built-in.o drivers/net/wireless/built-in.o drivers/net/usb/built-in.o 
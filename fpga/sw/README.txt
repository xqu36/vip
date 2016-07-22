--build_rootfs.sh
--Current Version: 1.0
--Setups the current working rootfs for SD card boot.

build_rootfs.sh builds the current working project to the provided SD card location. The rootfs partition of the SD card is required using the -t=[location] argument. Once run, the SD card should not be removed until after the end of script message is displayed. The SD card must already be formated according the the SD card setup wiki page. This script only builds the rootfs, and doesn't setup the BOOT.bin or image.ub files needed for boot. For additional arguements use the build_rootfs.sh --help command. 


--build_chroot.sh
--Current Version: 1.0
--Used in the build_rootfs.sh script to setup the user permissions and software packages.

build_chroot.sh is used in conjuction with the build_rootfs.sh script to setup the current rootfs project version. It is not necessary to run this script on its own, it will be executed through the build_rootfs script. To add new software packages, add them to the build_chroot.sh package list using the apt-get install command to have them automatically installed in future versions.

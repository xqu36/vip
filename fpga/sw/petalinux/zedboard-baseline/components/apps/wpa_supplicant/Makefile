ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include apps.common.mk

all: build install

build:

clean:

.PHONY: install image

install:
	# Please add commands below the comments to install data to target file system.
	# Use $(TARGETINST) to copy data into the target
	# E.g. there is data/wifiFirmware in the current directory, and I want to
	# copy it into the target "/" directory:
	#$(TARGETINST) -d data/wifiFirmware /wifiFirmware
	$(TARGETINST) -d data/wpa_supplicant /bin/wpa_supplicant
	$(TARGETINST) -d data/wpa_cli /bin/wpa_cli
	$(TARGETINST) -d data/libnl.so.1 /lib/libnl.so.1
	$(TARGETINST) -d data/libnl.so.1.1.4 /lib/libnl.so.1.1.4
	$(TARGETINST) -d data/wpa_supplicant.conf /etc/wpa_supplicant.conf

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  install                install built objects to rootfs host copy"

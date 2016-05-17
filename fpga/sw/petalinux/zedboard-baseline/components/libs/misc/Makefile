ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include libs.common.mk

#PETALINUX_REPO = ../../../../../drivers/pre-built
PETALINUX_REPO = /home/jdanner3/VIP/repos/vip/fpga/sw/drivers/pre-built

all: build install

.PHONY: build
build:

install:
	#find $(PETALINUX_REPO)/ -maxdepth 1 -name "*.*" -print0 | xargs -0 cp -pP -r -t "$(STAGEDIR)/usr/lib/"
	# Copy cross-compiled libraries from repository into target rootfs
	cp -rpP $(PETALINUX_REPO)/lib/* $(TARGETDIR)/usr/lib

clean:
	rm -rf *.o *.so *.so.* *.a

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  clean                  clean out build objects"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  build                  build subsystem"
	@echo "  install                install built objects to rootfs host copy"

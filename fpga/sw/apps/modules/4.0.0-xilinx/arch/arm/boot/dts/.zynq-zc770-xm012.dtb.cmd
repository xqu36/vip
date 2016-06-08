cmd_arch/arm/boot/dts/zynq-zc770-xm012.dtb := mkdir -p arch/arm/boot/dts/ ; arm-xilinx-linux-gnueabi-gcc -E -Wp,-MD,arch/arm/boot/dts/.zynq-zc770-xm012.dtb.d.pre.tmp -nostdinc -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/include -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/of/testcase-data -undef -D__DTS__ -x assembler-with-cpp -o arch/arm/boot/dts/.zynq-zc770-xm012.dtb.dts.tmp /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/zynq-zc770-xm012.dts ; ./scripts/dtc/dtc -O dtb -o arch/arm/boot/dts/zynq-zc770-xm012.dtb -b 0 -i /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/  -d arch/arm/boot/dts/.zynq-zc770-xm012.dtb.d.dtc.tmp arch/arm/boot/dts/.zynq-zc770-xm012.dtb.dts.tmp ; cat arch/arm/boot/dts/.zynq-zc770-xm012.dtb.d.pre.tmp arch/arm/boot/dts/.zynq-zc770-xm012.dtb.d.dtc.tmp > arch/arm/boot/dts/.zynq-zc770-xm012.dtb.d

source_arch/arm/boot/dts/zynq-zc770-xm012.dtb := /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/zynq-zc770-xm012.dts

deps_arch/arm/boot/dts/zynq-zc770-xm012.dtb := \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/zynq-7000.dtsi \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/skeleton.dtsi \

arch/arm/boot/dts/zynq-zc770-xm012.dtb: $(deps_arch/arm/boot/dts/zynq-zc770-xm012.dtb)

$(deps_arch/arm/boot/dts/zynq-zc770-xm012.dtb):

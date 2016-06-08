cmd_arch/arm/boot/dts/zynq-parallella.dtb := mkdir -p arch/arm/boot/dts/ ; arm-xilinx-linux-gnueabi-gcc -E -Wp,-MD,arch/arm/boot/dts/.zynq-parallella.dtb.d.pre.tmp -nostdinc -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/include -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/of/testcase-data -undef -D__DTS__ -x assembler-with-cpp -o arch/arm/boot/dts/.zynq-parallella.dtb.dts.tmp /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/zynq-parallella.dts ; ./scripts/dtc/dtc -O dtb -o arch/arm/boot/dts/zynq-parallella.dtb -b 0 -i /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/  -d arch/arm/boot/dts/.zynq-parallella.dtb.d.dtc.tmp arch/arm/boot/dts/.zynq-parallella.dtb.dts.tmp ; cat arch/arm/boot/dts/.zynq-parallella.dtb.d.pre.tmp arch/arm/boot/dts/.zynq-parallella.dtb.d.dtc.tmp > arch/arm/boot/dts/.zynq-parallella.dtb.d

source_arch/arm/boot/dts/zynq-parallella.dtb := /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/zynq-parallella.dts

deps_arch/arm/boot/dts/zynq-parallella.dtb := \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/zynq-7000.dtsi \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/boot/dts/skeleton.dtsi \

arch/arm/boot/dts/zynq-parallella.dtb: $(deps_arch/arm/boot/dts/zynq-parallella.dtb)

$(deps_arch/arm/boot/dts/zynq-parallella.dtb):

cmd_kernel/sys_ni.o := arm-xilinx-linux-gnueabi-gcc -Wp,-MD,kernel/.sys_ni.o.d  -nostdinc -isystem /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/bin/../lib/gcc/arm-xilinx-linux-gnueabi/4.9.2/include -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include -Iarch/arm/include/generated/uapi -Iarch/arm/include/generated  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include -Iinclude -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi -Iinclude/generated/uapi -include /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kconfig.h  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel -Ikernel -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -funwind-tables -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -fno-delete-null-pointer-checks -Os -Wno-maybe-uninitialized --param=allow-store-data-races=0 -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-var-tracking-assignments -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(sys_ni)"  -D"KBUILD_MODNAME=KBUILD_STR(sys_ni)" -c -o kernel/.tmp_sys_ni.o /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/sys_ni.c

source_kernel/sys_ni.o := /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/sys_ni.c

deps_kernel/sys_ni.o := \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/linkage.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/64bit.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compiler-gcc4.h \
    $(wildcard include/config/arch/use/builtin/bswap.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/int-ll64.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/int-ll64.h \
  arch/arm/include/generated/asm/bitsperlong.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitsperlong.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/bitsperlong.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/posix_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/stddef.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/stddef.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/posix_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/posix_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/stringify.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/export.h \
    $(wildcard include/config/have/underscore/symbol/prefix.h) \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/unused/symbols.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/linkage.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/errno.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/errno.h \
  arch/arm/include/generated/asm/errno.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/errno.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/errno-base.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/unistd.h \
    $(wildcard include/config/aeabi.h) \
    $(wildcard include/config/oabi/compat.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/unistd.h \

kernel/sys_ni.o: $(deps_kernel/sys_ni.o)

$(deps_kernel/sys_ni.o):

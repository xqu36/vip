cmd_drivers/staging/rtl8188eu/hal/bb_cfg.o := arm-xilinx-linux-gnueabi-gcc -Wp,-MD,drivers/staging/rtl8188eu/hal/.bb_cfg.o.d  -nostdinc -isystem /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/bin/../lib/gcc/arm-xilinx-linux-gnueabi/4.9.2/include -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include -Iarch/arm/include/generated/uapi -Iarch/arm/include/generated  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include -Iinclude -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi -Iinclude/generated/uapi -include /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kconfig.h  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu -Idrivers/staging/rtl8188eu -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -funwind-tables -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -fno-delete-null-pointer-checks -Os -Wno-maybe-uninitialized --param=allow-store-data-races=0 -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-var-tracking-assignments -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -DCC_HAVE_ASM_GOTO -D__CHECK_ENDIAN__  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include -Idrivers/staging/rtl8188eu/include  -DMODULE  -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(bb_cfg)"  -D"KBUILD_MODNAME=KBUILD_STR(r8188eu)" -c -o drivers/staging/rtl8188eu/hal/.tmp_bb_cfg.o /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/hal/bb_cfg.c

source_drivers/staging/rtl8188eu/hal/bb_cfg.o := /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/hal/bb_cfg.c

deps_drivers/staging/rtl8188eu/hal/bb_cfg.o := \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_precomp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/osdep_service.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/basic_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compiler-gcc4.h \
    $(wildcard include/config/arch/use/builtin/bswap.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/posix_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/posix_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/spinlock.h \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
    $(wildcard include/config/preempt.h) \
    $(wildcard include/config/debug/lock/alloc.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/typecheck.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/preempt.h \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/context/tracking.h) \
    $(wildcard include/config/preempt/notifiers.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/linkage.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/stringify.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/export.h \
    $(wildcard include/config/have/underscore/symbol/prefix.h) \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/unused/symbols.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/linkage.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/const.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/panic/timeout.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/lib/gcc/arm-xilinx-linux-gnueabi/4.9.2/include/stdarg.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bitops.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/bitops.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/irqflags.h \
    $(wildcard include/config/cpu/v7m.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/arm/thumb.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/ptrace.h \
    $(wildcard include/config/cpu/endian/be8.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/hwcap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/hwcap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/barrier.h \
    $(wildcard include/config/cpu/32v6k.h) \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/arch/has/barriers.h) \
    $(wildcard include/config/arm/dma/mem/bufferable.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/outercache.h \
    $(wildcard include/config/outer/cache/sync.h) \
    $(wildcard include/config/outer/cache.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/non-atomic.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/fls64.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/sched.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/hweight.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/arch_hweight.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/const_hweight.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/lock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/le.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/byteorder.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/byteorder/little_endian.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/byteorder/little_endian.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/swab.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/swab.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/swab.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/swab.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/byteorder/generic.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bitops/ext2-atomic-setbit.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/printk.h \
    $(wildcard include/config/message/loglevel/default.h) \
    $(wildcard include/config/early/printk.h) \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/init.h \
    $(wildcard include/config/broken/rodata.h) \
    $(wildcard include/config/lto.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kern_levels.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/kernel.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sysinfo.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/cache.h \
    $(wildcard include/config/arm/l1/cache/shift.h) \
    $(wildcard include/config/aeabi.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dynamic_debug.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/string.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/string.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/errno.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/errno.h \
  arch/arm/include/generated/asm/errno.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/errno.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/errno-base.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/div64.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/compiler.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/debug/bugverbose.h) \
    $(wildcard include/config/arm/lpae.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/opcodes.h \
    $(wildcard include/config/cpu/endian/be32.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  arch/arm/include/generated/asm/preempt.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/preempt.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/thread_info.h \
    $(wildcard include/config/compat.h) \
    $(wildcard include/config/debug/stack/usage.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bug.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/thread_info.h \
    $(wildcard include/config/crunch.h) \
    $(wildcard include/config/arm/thumbee.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/fpstate.h \
    $(wildcard include/config/vfpv3.h) \
    $(wildcard include/config/iwmmxt.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/page.h \
    $(wildcard include/config/cpu/copy/v4wt.h) \
    $(wildcard include/config/cpu/copy/v4wb.h) \
    $(wildcard include/config/cpu/copy/feroceon.h) \
    $(wildcard include/config/cpu/copy/fa.h) \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/xscale.h) \
    $(wildcard include/config/cpu/copy/v6.h) \
    $(wildcard include/config/kuser/helpers.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/glue.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/pgtable-2level-types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/memory.h \
    $(wildcard include/config/need/mach/memory/h.h) \
    $(wildcard include/config/page/offset.h) \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/dram/base.h) \
    $(wildcard include/config/dram/size.h) \
    $(wildcard include/config/have/tcm.h) \
    $(wildcard include/config/arm/patch/phys/virt.h) \
    $(wildcard include/config/phys/offset.h) \
    $(wildcard include/config/virt/to/bus.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sizes.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/memory_model.h \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
    $(wildcard include/config/sparsemem.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/getorder.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/domain.h \
    $(wildcard include/config/io/36.h) \
    $(wildcard include/config/cpu/use/domains.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bottom_half.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/preempt_mask.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/spinlock_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/spinlock_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/lockdep.h \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/lock/stat.h) \
    $(wildcard include/config/prove/rcu.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rwlock_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/spinlock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/prefetch.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/processor.h \
    $(wildcard include/config/have/hw/breakpoint.h) \
    $(wildcard include/config/arm/errata/754327.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/hw_breakpoint.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rwlock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/inline/spin/lock.h) \
    $(wildcard include/config/inline/spin/lock/bh.h) \
    $(wildcard include/config/inline/spin/lock/irq.h) \
    $(wildcard include/config/inline/spin/lock/irqsave.h) \
    $(wildcard include/config/inline/spin/trylock.h) \
    $(wildcard include/config/inline/spin/trylock/bh.h) \
    $(wildcard include/config/uninline/spin/unlock.h) \
    $(wildcard include/config/inline/spin/unlock/bh.h) \
    $(wildcard include/config/inline/spin/unlock/irq.h) \
    $(wildcard include/config/inline/spin/unlock/irqrestore.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/inline/read/lock.h) \
    $(wildcard include/config/inline/write/lock.h) \
    $(wildcard include/config/inline/read/lock/bh.h) \
    $(wildcard include/config/inline/write/lock/bh.h) \
    $(wildcard include/config/inline/read/lock/irq.h) \
    $(wildcard include/config/inline/write/lock/irq.h) \
    $(wildcard include/config/inline/read/lock/irqsave.h) \
    $(wildcard include/config/inline/write/lock/irqsave.h) \
    $(wildcard include/config/inline/read/trylock.h) \
    $(wildcard include/config/inline/write/trylock.h) \
    $(wildcard include/config/inline/read/unlock.h) \
    $(wildcard include/config/inline/write/unlock.h) \
    $(wildcard include/config/inline/read/unlock/bh.h) \
    $(wildcard include/config/inline/write/unlock/bh.h) \
    $(wildcard include/config/inline/read/unlock/irq.h) \
    $(wildcard include/config/inline/write/unlock/irq.h) \
    $(wildcard include/config/inline/read/unlock/irqrestore.h) \
    $(wildcard include/config/inline/write/unlock/irqrestore.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/atomic.h \
    $(wildcard include/config/arch/has/atomic/or.h) \
    $(wildcard include/config/generic/atomic64.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/atomic.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/cmpxchg.h \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/v6.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/cmpxchg-local.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/atomic-long.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/slab.h \
    $(wildcard include/config/slab/debug.h) \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/failslab.h) \
    $(wildcard include/config/slab.h) \
    $(wildcard include/config/slub.h) \
    $(wildcard include/config/slob.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/numa.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/gfp.h \
    $(wildcard include/config/zone/dma32.h) \
    $(wildcard include/config/pm/sleep.h) \
    $(wildcard include/config/cma.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/virtual.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/memory/isolation.h) \
    $(wildcard include/config/memcg.h) \
    $(wildcard include/config/memory/hotplug.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/have/memblock/node/map.h) \
    $(wildcard include/config/flat/node/mem/map.h) \
    $(wildcard include/config/page/extension.h) \
    $(wildcard include/config/no/bootmem.h) \
    $(wildcard include/config/numa/balancing.h) \
    $(wildcard include/config/have/memory/present.h) \
    $(wildcard include/config/have/memoryless/nodes.h) \
    $(wildcard include/config/need/node/memmap/size.h) \
    $(wildcard include/config/need/multiple/nodes.h) \
    $(wildcard include/config/have/arch/early/pfn/to/nid.h) \
    $(wildcard include/config/sparsemem/extreme.h) \
    $(wildcard include/config/nodes/span/other/nodes.h) \
    $(wildcard include/config/holes/in/zone.h) \
    $(wildcard include/config/arch/has/holes/memorymodel.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/wait.h \
  arch/arm/include/generated/asm/current.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/current.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/wait.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/seqlock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/nodemask.h \
    $(wildcard include/config/movable/node.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bitmap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/page-flags-layout.h \
  include/generated/bounds.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/memory_hotplug.h \
    $(wildcard include/config/memory/hotremove.h) \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
    $(wildcard include/config/have/bootmem/info/node.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/notifier.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mutex.h \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/mutex/spin/on/owner.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/osq_lock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rwsem.h \
    $(wildcard include/config/rwsem/spin/on/owner.h) \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  arch/arm/include/generated/asm/rwsem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/rwsem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/srcu.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rcupdate.h \
    $(wildcard include/config/tree/rcu.h) \
    $(wildcard include/config/preempt/rcu.h) \
    $(wildcard include/config/rcu/trace.h) \
    $(wildcard include/config/rcu/stall/common.h) \
    $(wildcard include/config/rcu/user/qs.h) \
    $(wildcard include/config/rcu/nocb/cpu.h) \
    $(wildcard include/config/tasks/rcu.h) \
    $(wildcard include/config/tiny/rcu.h) \
    $(wildcard include/config/debug/objects/rcu/head.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/rcu/boost.h) \
    $(wildcard include/config/rcu/nocb/cpu/all.h) \
    $(wildcard include/config/no/hz/full/sysidle.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
    $(wildcard include/config/disable/obsolete/cpumask/functions.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/completion.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects/free.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rcutree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
    $(wildcard include/config/sysfs.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ktime.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/math64.h \
    $(wildcard include/config/arch/supports/int128.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/time64.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/time.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/jiffies.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/timex.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/timex.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/param.h \
  arch/arm/include/generated/asm/param.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/param.h \
    $(wildcard include/config/hz.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/param.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/timex.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/timekeeping.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/topology.h \
    $(wildcard include/config/use/percpu/numa/node/id.h) \
    $(wildcard include/config/sched/smt.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/smp.h \
    $(wildcard include/config/up/late/init.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/llist.h \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/smp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pfn.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/percpu.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/percpu.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/topology.h \
    $(wildcard include/config/arm/cpu/topology.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/topology.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kmemleak.h \
    $(wildcard include/config/debug/kmemleak.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kasan.h \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/kasan/shadow/offset.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/module.h \
    $(wildcard include/config/module/sig.h) \
    $(wildcard include/config/kallsyms.h) \
    $(wildcard include/config/tracepoints.h) \
    $(wildcard include/config/event/tracing.h) \
    $(wildcard include/config/livepatch.h) \
    $(wildcard include/config/module/unload.h) \
    $(wildcard include/config/constructors.h) \
    $(wildcard include/config/debug/set/module/ronx.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/stat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/stat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/stat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uidgid.h \
    $(wildcard include/config/user/ns.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/highuid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kmod.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sysctl.h \
    $(wildcard include/config/sysctl.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rbtree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sysctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/elf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/elf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/user.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/elf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/elf-em.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kobject.h \
    $(wildcard include/config/uevent/helper.h) \
    $(wildcard include/config/debug/kobject/release.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sysfs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kernfs.h \
    $(wildcard include/config/kernfs.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/err.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/idr.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kobject_ns.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kref.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/moduleparam.h \
    $(wildcard include/config/alpha.h) \
    $(wildcard include/config/ia64.h) \
    $(wildcard include/config/ppc64.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/jump_label.h \
    $(wildcard include/config/jump/label.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/module.h \
    $(wildcard include/config/arm/unwind.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/module.h \
    $(wildcard include/config/have/mod/arch/specific.h) \
    $(wildcard include/config/modules/use/elf/rel.h) \
    $(wildcard include/config/modules/use/elf/rela.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/netdevice.h \
    $(wildcard include/config/dcb.h) \
    $(wildcard include/config/wlan.h) \
    $(wildcard include/config/ax25.h) \
    $(wildcard include/config/mac80211/mesh.h) \
    $(wildcard include/config/net/ipip.h) \
    $(wildcard include/config/net/ipgre.h) \
    $(wildcard include/config/ipv6/sit.h) \
    $(wildcard include/config/ipv6/tunnel.h) \
    $(wildcard include/config/rps.h) \
    $(wildcard include/config/netpoll.h) \
    $(wildcard include/config/xps.h) \
    $(wildcard include/config/bql.h) \
    $(wildcard include/config/rfs/accel.h) \
    $(wildcard include/config/fcoe.h) \
    $(wildcard include/config/net/poll/controller.h) \
    $(wildcard include/config/net/rx/busy/poll.h) \
    $(wildcard include/config/libfcoe.h) \
    $(wildcard include/config/net/switchdev.h) \
    $(wildcard include/config/wireless/ext.h) \
    $(wildcard include/config/vlan/8021q.h) \
    $(wildcard include/config/net/dsa.h) \
    $(wildcard include/config/tipc.h) \
    $(wildcard include/config/net/ns.h) \
    $(wildcard include/config/cgroup/net/prio.h) \
    $(wildcard include/config/net/flow/limit.h) \
    $(wildcard include/config/proc/fs.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pm_qos.h \
    $(wildcard include/config/pm.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/plist.h \
    $(wildcard include/config/debug/pi/list.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/miscdevice.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/major.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/device.h \
    $(wildcard include/config/debug/devres.h) \
    $(wildcard include/config/acpi.h) \
    $(wildcard include/config/pinctrl.h) \
    $(wildcard include/config/dma/cma.h) \
    $(wildcard include/config/devtmpfs.h) \
    $(wildcard include/config/sysfs/deprecated.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ioport.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/klist.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pinctrl/devinfo.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pinctrl/consumer.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/seq_file.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pinctrl/pinctrl-state.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pm.h \
    $(wildcard include/config/vt/console/sleep.h) \
    $(wildcard include/config/pm/clk.h) \
    $(wildcard include/config/pm/generic/domains.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ratelimit.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/device.h \
    $(wildcard include/config/dmabounce.h) \
    $(wildcard include/config/iommu/api.h) \
    $(wildcard include/config/arm/dma/use/iommu.h) \
    $(wildcard include/config/arch/omap.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pm_wakeup.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/delay.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/delay.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rculist.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dmaengine.h \
    $(wildcard include/config/async/tx/enable/channel/switch.h) \
    $(wildcard include/config/dma/engine.h) \
    $(wildcard include/config/rapidio/dma/engine.h) \
    $(wildcard include/config/async/tx/dma.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uio.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/uio.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/scatterlist.h \
    $(wildcard include/config/debug/sg.h) \
    $(wildcard include/config/arch/has/sg/chain.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mm.h \
    $(wildcard include/config/mem/soft/dirty.h) \
    $(wildcard include/config/x86.h) \
    $(wildcard include/config/ppc.h) \
    $(wildcard include/config/parisc.h) \
    $(wildcard include/config/metag.h) \
    $(wildcard include/config/stack/growsup.h) \
    $(wildcard include/config/transparent/hugepage.h) \
    $(wildcard include/config/ksm.h) \
    $(wildcard include/config/shmem.h) \
    $(wildcard include/config/debug/vm/rb.h) \
    $(wildcard include/config/debug/pagealloc.h) \
    $(wildcard include/config/hibernation.h) \
    $(wildcard include/config/hugetlbfs.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/debug_locks.h \
    $(wildcard include/config/debug/locking/api/selftests.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mm_types.h \
    $(wildcard include/config/split/ptlock/cpus.h) \
    $(wildcard include/config/arch/enable/split/pmd/ptlock.h) \
    $(wildcard include/config/have/cmpxchg/double.h) \
    $(wildcard include/config/have/aligned/struct/page.h) \
    $(wildcard include/config/aio.h) \
    $(wildcard include/config/mmu/notifier.h) \
    $(wildcard include/config/x86/intel/mpx.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/auxvec.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/auxvec.h \
  arch/arm/include/generated/asm/auxvec.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/auxvec.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uprobes.h \
    $(wildcard include/config/uprobes.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/mmu.h \
    $(wildcard include/config/cpu/has/asid.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/range.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bit_spinlock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/shrinker.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/resource.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/resource.h \
  arch/arm/include/generated/asm/resource.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/resource.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/resource.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/page_ext.h \
    $(wildcard include/config/page/owner.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/stacktrace.h \
    $(wildcard include/config/stacktrace.h) \
    $(wildcard include/config/user/stacktrace/support.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/pgtable.h \
    $(wildcard include/config/highpte.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/proc-fns.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/glue-proc.h \
    $(wildcard include/config/cpu/arm7tdmi.h) \
    $(wildcard include/config/cpu/arm720t.h) \
    $(wildcard include/config/cpu/arm740t.h) \
    $(wildcard include/config/cpu/arm9tdmi.h) \
    $(wildcard include/config/cpu/arm920t.h) \
    $(wildcard include/config/cpu/arm922t.h) \
    $(wildcard include/config/cpu/arm925t.h) \
    $(wildcard include/config/cpu/arm926t.h) \
    $(wildcard include/config/cpu/arm940t.h) \
    $(wildcard include/config/cpu/arm946e.h) \
    $(wildcard include/config/cpu/arm1020.h) \
    $(wildcard include/config/cpu/arm1020e.h) \
    $(wildcard include/config/cpu/arm1022.h) \
    $(wildcard include/config/cpu/arm1026.h) \
    $(wildcard include/config/cpu/mohawk.h) \
    $(wildcard include/config/cpu/feroceon.h) \
    $(wildcard include/config/cpu/v6k.h) \
    $(wildcard include/config/cpu/pj4b.h) \
    $(wildcard include/config/cpu/v7.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/pgtable-nopud.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/pgtable-hwdef.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/pgtable-2level-hwdef.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/tlbflush.h \
    $(wildcard include/config/smp/on/up.h) \
    $(wildcard include/config/cpu/tlb/v4wt.h) \
    $(wildcard include/config/cpu/tlb/fa.h) \
    $(wildcard include/config/cpu/tlb/v4wbi.h) \
    $(wildcard include/config/cpu/tlb/feroceon.h) \
    $(wildcard include/config/cpu/tlb/v4wb.h) \
    $(wildcard include/config/cpu/tlb/v6.h) \
    $(wildcard include/config/cpu/tlb/v7.h) \
    $(wildcard include/config/arm/errata/720789.h) \
    $(wildcard include/config/arm/errata/798181.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sched.h \
    $(wildcard include/config/sched/debug.h) \
    $(wildcard include/config/no/hz/common.h) \
    $(wildcard include/config/lockup/detector.h) \
    $(wildcard include/config/detect/hung/task.h) \
    $(wildcard include/config/core/dump/default/elf/headers.h) \
    $(wildcard include/config/sched/autogroup.h) \
    $(wildcard include/config/virt/cpu/accounting/native.h) \
    $(wildcard include/config/bsd/process/acct.h) \
    $(wildcard include/config/taskstats.h) \
    $(wildcard include/config/audit.h) \
    $(wildcard include/config/cgroups.h) \
    $(wildcard include/config/inotify/user.h) \
    $(wildcard include/config/fanotify.h) \
    $(wildcard include/config/epoll.h) \
    $(wildcard include/config/posix/mqueue.h) \
    $(wildcard include/config/keys.h) \
    $(wildcard include/config/perf/events.h) \
    $(wildcard include/config/schedstats.h) \
    $(wildcard include/config/task/delay/acct.h) \
    $(wildcard include/config/sched/mc.h) \
    $(wildcard include/config/fair/group/sched.h) \
    $(wildcard include/config/rt/group/sched.h) \
    $(wildcard include/config/cgroup/sched.h) \
    $(wildcard include/config/blk/dev/io/trace.h) \
    $(wildcard include/config/compat/brk.h) \
    $(wildcard include/config/memcg/kmem.h) \
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/virt/cpu/accounting/gen.h) \
    $(wildcard include/config/sysvipc.h) \
    $(wildcard include/config/auditsyscall.h) \
    $(wildcard include/config/rt/mutexes.h) \
    $(wildcard include/config/block.h) \
    $(wildcard include/config/task/xacct.h) \
    $(wildcard include/config/cpusets.h) \
    $(wildcard include/config/futex.h) \
    $(wildcard include/config/fault/injection.h) \
    $(wildcard include/config/latencytop.h) \
    $(wildcard include/config/function/graph/tracer.h) \
    $(wildcard include/config/bcache.h) \
    $(wildcard include/config/have/unstable/sched/clock.h) \
    $(wildcard include/config/irq/time/accounting.h) \
    $(wildcard include/config/no/hz/full.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sched.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sched/prio.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/capability.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/capability.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cputime.h \
  arch/arm/include/generated/asm/cputime.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/cputime.h \
    $(wildcard include/config/virt/cpu/accounting.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/cputime_jiffies.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ipc.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/ipc.h \
  arch/arm/include/generated/asm/ipcbuf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/ipcbuf.h \
  arch/arm/include/generated/asm/sembuf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/sembuf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/shm.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/shm.h \
  arch/arm/include/generated/asm/shmbuf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/shmbuf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/shmparam.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/signal.h \
    $(wildcard include/config/old/sigaction.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/signal.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/signal.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/signal.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/signal-defs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/sigcontext.h \
  arch/arm/include/generated/asm/siginfo.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/siginfo.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/siginfo.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/proportions.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu_counter.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/seccomp.h \
    $(wildcard include/config/seccomp.h) \
    $(wildcard include/config/have/arch/seccomp/filter.h) \
    $(wildcard include/config/seccomp/filter.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/seccomp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rtmutex.h \
    $(wildcard include/config/debug/rt/mutexes.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/hrtimer.h \
    $(wildcard include/config/high/res/timers.h) \
    $(wildcard include/config/timerfd.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/timerqueue.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/task_io_accounting.h \
    $(wildcard include/config/task/io/accounting.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/latencytop.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cred.h \
    $(wildcard include/config/debug/credentials.h) \
    $(wildcard include/config/security.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/key.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/assoc_array.h \
    $(wildcard include/config/associative/array.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/selinux.h \
    $(wildcard include/config/security/selinux.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/magic.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/pgtable-2level.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/pgtable.h \
    $(wildcard include/config/have/arch/soft/dirty.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/page-flags.h \
    $(wildcard include/config/pageflags/extended.h) \
    $(wildcard include/config/arch/uses/pg/uncached.h) \
    $(wildcard include/config/memory/failure.h) \
    $(wildcard include/config/swap.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/huge_mm.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/vmstat.h \
    $(wildcard include/config/vm/event/counters.h) \
    $(wildcard include/config/debug/tlbflush.h) \
    $(wildcard include/config/debug/vm/vmacache.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/vm_event_item.h \
    $(wildcard include/config/migration.h) \
    $(wildcard include/config/memory/balloon.h) \
    $(wildcard include/config/balloon/compaction.h) \
  arch/arm/include/generated/asm/scatterlist.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/scatterlist.h \
    $(wildcard include/config/need/sg/dma/length.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/io.h \
    $(wildcard include/config/pci.h) \
    $(wildcard include/config/need/mach/io/h.h) \
    $(wildcard include/config/pcmcia/soc/common.h) \
    $(wildcard include/config/isa.h) \
    $(wildcard include/config/pccard.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/blk_types.h \
    $(wildcard include/config/blk/cgroup.h) \
    $(wildcard include/config/blk/dev/integrity.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/pci_iomap.h \
    $(wildcard include/config/no/generic/pci/ioport/map.h) \
    $(wildcard include/config/generic/pci/iomap.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/xen/xen.h \
    $(wildcard include/config/xen.h) \
    $(wildcard include/config/xen/dom0.h) \
    $(wildcard include/config/xen/pvh.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/io.h \
    $(wildcard include/config/generic/iomap.h) \
    $(wildcard include/config/has/ioport/map.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/vmalloc.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dynamic_queue_limits.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ethtool.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/compat.h \
    $(wildcard include/config/compat/old/sigaction.h) \
    $(wildcard include/config/odd/rt/sigaction.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/ethtool.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/if_ether.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/skbuff.h \
    $(wildcard include/config/nf/conntrack.h) \
    $(wildcard include/config/bridge/netfilter.h) \
    $(wildcard include/config/xfrm.h) \
    $(wildcard include/config/ipv6/ndisc/nodetype.h) \
    $(wildcard include/config/net/sched.h) \
    $(wildcard include/config/net/cls/act.h) \
    $(wildcard include/config/network/secmark.h) \
    $(wildcard include/config/network/phy/timestamping.h) \
    $(wildcard include/config/netfilter/xt/target/trace.h) \
    $(wildcard include/config/nf/tables.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kmemcheck.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/socket.h \
  arch/arm/include/generated/asm/socket.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/socket.h \
  arch/arm/include/generated/asm/sockios.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/sockios.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sockios.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/socket.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/net.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/random.h \
    $(wildcard include/config/arch/random.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/random.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/ioctl.h \
  arch/arm/include/generated/asm/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/irqnr.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/irqnr.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/net.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/textsearch.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/checksum.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/uaccess.h \
    $(wildcard include/config/have/efficient/unaligned/access.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/checksum.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/in6.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/in6.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/libc-compat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dma-mapping.h \
    $(wildcard include/config/has/dma.h) \
    $(wildcard include/config/arch/has/dma/set/coherent/mask.h) \
    $(wildcard include/config/have/dma/attrs.h) \
    $(wildcard include/config/need/dma/map/state.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dma-attrs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dma-direction.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/dma-mapping.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dma-debug.h \
    $(wildcard include/config/dma/api/debug.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/dma-coherent.h \
    $(wildcard include/config/have/generic/dma/coherent.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/xen/hypervisor.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/dma-mapping-common.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/netdev_features.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/flow_keys.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if_ether.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/net_namespace.h \
    $(wildcard include/config/ipv6.h) \
    $(wildcard include/config/ieee802154/6lowpan.h) \
    $(wildcard include/config/ip/sctp.h) \
    $(wildcard include/config/ip/dccp.h) \
    $(wildcard include/config/netfilter.h) \
    $(wildcard include/config/nf/defrag/ipv6.h) \
    $(wildcard include/config/wext/core.h) \
    $(wildcard include/config/ip/vs.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/flow.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/core.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/mib.h \
    $(wildcard include/config/xfrm/statistics.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/snmp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/snmp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/u64_stats_sync.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/unix.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/packet.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/ipv4.h \
    $(wildcard include/config/ip/multiple/tables.h) \
    $(wildcard include/config/ip/route/classid.h) \
    $(wildcard include/config/ip/mroute.h) \
    $(wildcard include/config/ip/mroute/multiple/tables.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/inet_frag.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/ipv6.h \
    $(wildcard include/config/ipv6/multiple/tables.h) \
    $(wildcard include/config/ipv6/mroute.h) \
    $(wildcard include/config/ipv6/mroute/multiple/tables.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/dst_ops.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/ieee802154_6lowpan.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/sctp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/dccp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/netfilter.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/proc_fs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/fs.h \
    $(wildcard include/config/fs/posix/acl.h) \
    $(wildcard include/config/ima.h) \
    $(wildcard include/config/fsnotify.h) \
    $(wildcard include/config/file/locking.h) \
    $(wildcard include/config/quota.h) \
    $(wildcard include/config/fs/dax.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kdev_t.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/kdev_t.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dcache.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rculist_bl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/list_bl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/lockref.h \
    $(wildcard include/config/arch/use/cmpxchg/lockref.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/path.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/list_lru.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/radix-tree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/semaphore.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/fiemap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/migrate_mode.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu-rwsem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/fs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/limits.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/quota.h \
    $(wildcard include/config/quota/netlink/interface.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/dqblk_xfs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dqblk_v1.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dqblk_v2.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dqblk_qtree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/projid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/quota.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/nfs_fs_i.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/netfilter.h \
    $(wildcard include/config/nf/nat/needed.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/hdlc/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/in.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/in.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/static_key.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/netfilter.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/x_tables.h \
    $(wildcard include/config/bridge/nf/ebtables.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/nftables.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netns/xfrm.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/xfrm.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/flowcache.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/interrupt.h \
    $(wildcard include/config/irq/forced/threading.h) \
    $(wildcard include/config/generic/irq/probe.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/irqreturn.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/hardirq.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ftrace_irq.h \
    $(wildcard include/config/ftrace/nmi/enter.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/vtime.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/context_tracking_state.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/hardirq.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/irq.h \
    $(wildcard include/config/sparse/irq.h) \
    $(wildcard include/config/multi/irq/handler.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/irq_cpustat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ns_common.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/seq_file_net.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/nsproxy.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/dsa.h \
    $(wildcard include/config/net/dsa/hwmon.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/of.h \
    $(wildcard include/config/sparc.h) \
    $(wildcard include/config/of/dynamic.h) \
    $(wildcard include/config/of.h) \
    $(wildcard include/config/attach/node.h) \
    $(wildcard include/config/detach/node.h) \
    $(wildcard include/config/add/property.h) \
    $(wildcard include/config/remove/property.h) \
    $(wildcard include/config/update/property.h) \
    $(wildcard include/config/no/change.h) \
    $(wildcard include/config/change/add.h) \
    $(wildcard include/config/change/remove.h) \
    $(wildcard include/config/of/resolve.h) \
    $(wildcard include/config/of/overlay.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mod_devicetable.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uuid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/uuid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/property.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/phy.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mii.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/mii.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/phy_fixed.h \
    $(wildcard include/config/fixed/phy.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/netprio_cgroup.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cgroup.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/cgroupstats.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/taskstats.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu-refcount.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cgroup_subsys.h \
    $(wildcard include/config/cgroup/cpuacct.h) \
    $(wildcard include/config/cgroup/device.h) \
    $(wildcard include/config/cgroup/freezer.h) \
    $(wildcard include/config/cgroup/net/classid.h) \
    $(wildcard include/config/cgroup/perf.h) \
    $(wildcard include/config/cgroup/hugetlb.h) \
    $(wildcard include/config/cgroup/debug.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/neighbour.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/netlink.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/scm.h \
    $(wildcard include/config/security/network.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/security.h \
    $(wildcard include/config/fw/loader/user/helper.h) \
    $(wildcard include/config/security/path.h) \
    $(wildcard include/config/security/network/xfrm.h) \
    $(wildcard include/config/securityfs.h) \
    $(wildcard include/config/security/yama.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/netlink.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/netdevice.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if_packet.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/if_link.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if_link.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if_bonding.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/circ_buf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uaccess.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/io.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/etherdevice.h \
  arch/arm/include/generated/asm/unaligned.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/unaligned.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/unaligned/access_ok.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/unaligned/generic.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/wireless.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/wireless.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/net/iw_handler.h \
    $(wildcard include/config/wext/priv.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/if_arp.h \
    $(wildcard include/config/firewire/net.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if_arp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rtnetlink.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/rtnetlink.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/if_addr.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ip.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/ip.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kthread.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/usb.h \
    $(wildcard include/config/usb/mon.h) \
    $(wildcard include/config/usb/led/trig.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/usb/ch9.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/usb/ch9.h \
    $(wildcard include/config/size.h) \
    $(wildcard include/config/att/one.h) \
    $(wildcard include/config/att/selfpower.h) \
    $(wildcard include/config/att/wakeup.h) \
    $(wildcard include/config/att/battery.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pm_runtime.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/drv_types.h \
    $(wildcard include/config/1t1r.h) \
    $(wildcard include/config/2t2r.h) \
    $(wildcard include/config/88eu/ap/mode.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/wlan_bssdef.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_ht.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/wifi.h \
    $(wildcard include/config/error.h) \
    $(wildcard include/config/method/flash.h) \
    $(wildcard include/config/method/ethernet.h) \
    $(wildcard include/config/method/label.h) \
    $(wildcard include/config/method/display.h) \
    $(wildcard include/config/method/e/nfc.h) \
    $(wildcard include/config/method/i/nfc.h) \
    $(wildcard include/config/method/nfc.h) \
    $(wildcard include/config/method/pbc.h) \
    $(wildcard include/config/method/keypad.h) \
    $(wildcard include/config/method/vpbc.h) \
    $(wildcard include/config/method/ppbc.h) \
    $(wildcard include/config/method/vdisplay.h) \
    $(wildcard include/config/method/pdisplay.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_cmd.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_rf.h \
    $(wildcard include/config/.h) \
    $(wildcard include/config/1t.h) \
    $(wildcard include/config/2t.h) \
    $(wildcard include/config/1r.h) \
    $(wildcard include/config/2r.h) \
    $(wildcard include/config/1t2r.h) \
    $(wildcard include/config/turbo.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_led.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/ieee80211.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_xmit.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/xmit_osdep.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_recv.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/hal_intf.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/Hal8188EPhyCfg.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/hal_com.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/HalVerDef.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_qos.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_security.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_eeprom.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/sta_info.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/wifi.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_mlme.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/mlme_osdep.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_debug.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_event.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_ap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/usb_ops_linux.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm.h \
    $(wildcard include/config/bb/phy/reg.h) \
    $(wildcard include/config/bb/agc/tab.h) \
    $(wildcard include/config/bb/agc/tab/2g.h) \
    $(wildcard include/config/bb/agc/tab/5g.h) \
    $(wildcard include/config/bb/phy/reg/pg.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_HWConfig.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_debug.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_RegDefine11N.h \
    $(wildcard include/config/anta/11n.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/Hal8188ERateAdaptive.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_hal.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_spec.h \
    $(wildcard include/config/err.h) \
    $(wildcard include/config/usedk.h) \
    $(wildcard include/config/no/usedk.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/Hal8188EPhyReg.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/Hal8188EPhyCfg.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_dm.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_recv.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_cmd.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/pwrseq.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/pwrseqcmd.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_efuse.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtw_sreset.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/rtl8188e_hal.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_precomp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/hal_com.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_reg.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm_RTL8188E.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/phy.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/drivers/staging/rtl8188eu/include/odm.h \

drivers/staging/rtl8188eu/hal/bb_cfg.o: $(deps_drivers/staging/rtl8188eu/hal/bb_cfg.o)

$(deps_drivers/staging/rtl8188eu/hal/bb_cfg.o):

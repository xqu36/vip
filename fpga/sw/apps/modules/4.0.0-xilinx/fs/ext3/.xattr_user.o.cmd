cmd_fs/ext3/xattr_user.o := arm-xilinx-linux-gnueabi-gcc -Wp,-MD,fs/ext3/.xattr_user.o.d  -nostdinc -isystem /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/bin/../lib/gcc/arm-xilinx-linux-gnueabi/4.9.2/include -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include -Iarch/arm/include/generated/uapi -Iarch/arm/include/generated  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include -Iinclude -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi -Iinclude/generated/uapi -include /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kconfig.h  -I/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/fs/ext3 -Ifs/ext3 -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -funwind-tables -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -fno-delete-null-pointer-checks -Os -Wno-maybe-uninitialized --param=allow-store-data-races=0 -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-var-tracking-assignments -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(xattr_user)"  -D"KBUILD_MODNAME=KBUILD_STR(ext3)" -c -o fs/ext3/.tmp_xattr_user.o /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/fs/ext3/xattr_user.c

source_fs/ext3/xattr_user.o := /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/fs/ext3/xattr_user.c

deps_fs/ext3/xattr_user.o := \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/fs/ext3/ext3.h \
    $(wildcard include/config/jbd/debug.h) \
    $(wildcard include/config/quota.h) \
    $(wildcard include/config/ext3/fs/xattr.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/fs.h \
    $(wildcard include/config/sysfs.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/fs/posix/acl.h) \
    $(wildcard include/config/security.h) \
    $(wildcard include/config/ima.h) \
    $(wildcard include/config/fsnotify.h) \
    $(wildcard include/config/preempt.h) \
    $(wildcard include/config/epoll.h) \
    $(wildcard include/config/file/locking.h) \
    $(wildcard include/config/debug/lock/alloc.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/fs/dax.h) \
    $(wildcard include/config/block.h) \
    $(wildcard include/config/migration.h) \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/wait.h \
    $(wildcard include/config/lockdep.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/const.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
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
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/typecheck.h \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/spinlock.h \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/preempt.h \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/context/tracking.h) \
    $(wildcard include/config/preempt/notifiers.h) \
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
  arch/arm/include/generated/asm/current.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/current.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/wait.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kdev_t.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/kdev_t.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dcache.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rculist.h \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
    $(wildcard include/config/disable/obsolete/cpumask/functions.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bitmap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/seqlock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/completion.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/debug/objects/free.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rcutree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rculist_bl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/list_bl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/bit_spinlock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/lockref.h \
    $(wildcard include/config/arch/use/cmpxchg/lockref.h) \
  include/generated/bounds.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/path.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/stat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/stat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/stat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/math64.h \
    $(wildcard include/config/arch/supports/int128.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/time64.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/time.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uidgid.h \
    $(wildcard include/config/user/ns.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/highuid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/list_lru.h \
    $(wildcard include/config/memcg/kmem.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/nodemask.h \
    $(wildcard include/config/movable/node.h) \
    $(wildcard include/config/numa.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/shrinker.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/llist.h \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/radix-tree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rbtree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mutex.h \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/mutex/spin/on/owner.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/osq_lock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/rwsem.h \
    $(wildcard include/config/rwsem/spin/on/owner.h) \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  arch/arm/include/generated/asm/rwsem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/rwsem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/capability.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/capability.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/semaphore.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/fiemap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/migrate_mode.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu-rwsem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/virtual.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/smp.h \
    $(wildcard include/config/up/late/init.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/smp.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pfn.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/percpu.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/percpu.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/blk_types.h \
    $(wildcard include/config/blk/cgroup.h) \
    $(wildcard include/config/blk/dev/integrity.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/fs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/limits.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/ioctl.h \
  arch/arm/include/generated/asm/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/ioctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/quota.h \
    $(wildcard include/config/quota/netlink/interface.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/percpu_counter.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/gfp.h \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
    $(wildcard include/config/pm/sleep.h) \
    $(wildcard include/config/cma.h) \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/page-flags-layout.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/memory_hotplug.h \
    $(wildcard include/config/memory/hotremove.h) \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
    $(wildcard include/config/have/bootmem/info/node.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/notifier.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/srcu.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ktime.h \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/topology.h \
    $(wildcard include/config/arm/cpu/topology.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/asm-generic/topology.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/dqblk_xfs.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dqblk_v1.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dqblk_v2.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/dqblk_qtree.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/projid.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/quota.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/nfs_fs_i.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi/asm/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/asm-generic/fcntl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/err.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/jbd.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/buffer_head.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/pagemap.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/mm.h \
    $(wildcard include/config/sysctl.h) \
    $(wildcard include/config/mem/soft/dirty.h) \
    $(wildcard include/config/x86.h) \
    $(wildcard include/config/ppc.h) \
    $(wildcard include/config/parisc.h) \
    $(wildcard include/config/metag.h) \
    $(wildcard include/config/ia64.h) \
    $(wildcard include/config/stack/growsup.h) \
    $(wildcard include/config/transparent/hugepage.h) \
    $(wildcard include/config/ksm.h) \
    $(wildcard include/config/shmem.h) \
    $(wildcard include/config/debug/vm/rb.h) \
    $(wildcard include/config/proc/fs.h) \
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
    $(wildcard include/config/kmemcheck.h) \
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
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/virt/cpu/accounting/gen.h) \
    $(wildcard include/config/sysvipc.h) \
    $(wildcard include/config/auditsyscall.h) \
    $(wildcard include/config/rt/mutexes.h) \
    $(wildcard include/config/task/xacct.h) \
    $(wildcard include/config/cpusets.h) \
    $(wildcard include/config/futex.h) \
    $(wildcard include/config/fault/injection.h) \
    $(wildcard include/config/latencytop.h) \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/function/graph/tracer.h) \
    $(wildcard include/config/bcache.h) \
    $(wildcard include/config/have/unstable/sched/clock.h) \
    $(wildcard include/config/irq/time/accounting.h) \
    $(wildcard include/config/no/hz/full.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sched.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sched/prio.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/plist.h \
    $(wildcard include/config/debug/pi/list.h) \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/proportions.h \
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
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/key.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/sysctl.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/sysctl.h \
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
    $(wildcard include/config/memory/balloon.h) \
    $(wildcard include/config/balloon/compaction.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/highmem.h \
    $(wildcard include/config/x86/32.h) \
    $(wildcard include/config/debug/highmem.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/uaccess.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/uaccess.h \
    $(wildcard include/config/have/efficient/unaligned/access.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/hardirq.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/ftrace_irq.h \
    $(wildcard include/config/ftrace/nmi/enter.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/vtime.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/context_tracking_state.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/static_key.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/jump_label.h \
    $(wildcard include/config/jump/label.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/hardirq.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/irq.h \
    $(wildcard include/config/sparse/irq.h) \
    $(wildcard include/config/multi/irq/handler.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/irq_cpustat.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/cacheflush.h \
    $(wildcard include/config/arm/errata/411920.h) \
    $(wildcard include/config/cpu/cache/vipt.h) \
    $(wildcard include/config/frame/pointer.h) \
    $(wildcard include/config/debug/rodata.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/glue-cache.h \
    $(wildcard include/config/cpu/cache/v4.h) \
    $(wildcard include/config/cpu/cache/v4wb.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/cachetype.h \
    $(wildcard include/config/cpu/cache/vivt.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/kmap_types.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/asm/highmem.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/hugetlb_inline.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/journal-head.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/slab.h \
    $(wildcard include/config/slab/debug.h) \
    $(wildcard include/config/failslab.h) \
    $(wildcard include/config/slab.h) \
    $(wildcard include/config/slub.h) \
    $(wildcard include/config/slob.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kmemleak.h \
    $(wildcard include/config/debug/kmemleak.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kasan.h \
    $(wildcard include/config/kasan/shadow/offset.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/jbd_common.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/blockgroup_lock.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/trace/events/ext3.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/tracepoint.h \
    $(wildcard include/config/have/syscall/tracepoints.h) \
    $(wildcard include/config/tracepoints.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/trace/define_trace.h \
    $(wildcard include/config/event/tracing.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/fs/ext3/xattr.h \
    $(wildcard include/config/ext3/fs/security.h) \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/xattr.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/xattr.h \
  /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi/linux/libc-compat.h \

fs/ext3/xattr_user.o: $(deps_fs/ext3/xattr_user.o)

$(deps_fs/ext3/xattr_user.o):

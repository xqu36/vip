	.arch armv7-a
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 4	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"bounds.c"
@ GNU C (Sourcery CodeBench Lite 2015.05-17) version 4.9.2 (arm-xilinx-linux-gnueabi)
@	compiled by GNU C version 4.7.2, GMP version 6.0.0, MPFR version 3.1.2-p8, MPC version 1.0.2
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -nostdinc
@ -I /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include
@ -I arch/arm/include/generated/uapi -I arch/arm/include/generated
@ -I /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include
@ -I include
@ -I /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/arch/arm/include/uapi
@ -I arch/arm/include/generated/uapi
@ -I /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/uapi
@ -I include/generated/uapi
@ -I /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/.
@ -I .
@ -iprefix /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/bin/../lib/gcc/arm-xilinx-linux-gnueabi/4.9.2/
@ -isysroot /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/bin/../arm-xilinx-linux-gnueabi/libc
@ -D __KERNEL__ -D __LINUX_ARM_ARCH__=7 -U arm -D CC_HAVE_ASM_GOTO
@ -D KBUILD_STR(s)=#s -D KBUILD_BASENAME=KBUILD_STR(bounds)
@ -D KBUILD_MODNAME=KBUILD_STR(bounds) -D __CS_SOURCERYGXX_MAJ__=2015
@ -D __CS_SOURCERYGXX_MIN__=5 -D __CS_SOURCERYGXX_REV__=17
@ -isystem /opt/pkg/petalinux-v2015.4-final/tools/linux-i386/arm-xilinx-linux-gnueabi/bin/../lib/gcc/arm-xilinx-linux-gnueabi/4.9.2/include
@ -include /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/include/linux/kconfig.h
@ -MD kernel/.bounds.s.d
@ /opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/bounds.c
@ -mlittle-endian -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -marm
@ -march=armv7-a -mfloat-abi=soft -mtls-dialect=gnu
@ -auxbase-strip kernel/bounds.s -Os -Wall -Wundef -Wstrict-prototypes
@ -Wno-trigraphs -Werror=implicit-function-declaration -Wno-format-security
@ -Wno-maybe-uninitialized -Wframe-larger-than=1024
@ -Wno-unused-but-set-variable -Wdeclaration-after-statement
@ -Wno-pointer-sign -Werror=implicit-int -Werror=strict-prototypes
@ -Werror=date-time -std=gnu90 -fno-strict-aliasing -fno-common
@ -fno-dwarf2-cfi-asm -funwind-tables -fno-delete-null-pointer-checks
@ -fno-stack-protector -fomit-frame-pointer -fno-var-tracking-assignments
@ -fno-strict-overflow -fconserve-stack -fverbose-asm
@ --param allow-store-data-races=0
@ options enabled:  -faggressive-loop-optimizations -fauto-inc-dec
@ -fbranch-count-reg -fcaller-saves -fcombine-stack-adjustments
@ -fcompare-elim -fcprop-registers -fcrossjumping -fcse-follow-jumps
@ -fdefer-pop -fdevirtualize -fdevirtualize-speculatively -fearly-inlining
@ -feliminate-unused-debug-types -fexpensive-optimizations
@ -fforward-propagate -ffunction-cse -fgcse -fgcse-lm -fgnu-runtime
@ -fgnu-unique -fguess-branch-probability -fhoist-adjacent-loads -fident
@ -fif-conversion -fif-conversion2 -findirect-inlining -finline
@ -finline-atomics -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-cp -fipa-profile -fipa-pure-const
@ -fipa-reference -fipa-sra -fira-hoist-pressure -fira-share-save-slots
@ -fira-share-spill-slots -fisolate-erroneous-paths-dereference -fivopts
@ -fkeep-static-consts -fleading-underscore -fmath-errno -fmerge-constants
@ -fmerge-debug-strings -fmove-loop-invariants -fomit-frame-pointer
@ -foptimize-sibling-calls -fpartial-inlining -fpeephole -fpeephole2
@ -fprefetch-loop-arrays -freg-struct-return -freorder-blocks
@ -freorder-functions -frerun-cse-after-loop
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-pressure -fsched-rank-heuristic -fsched-spec
@ -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-insns2
@ -fsection-anchors -fshow-column -fshrink-wrap -fsigned-zeros
@ -fsplit-ivs-in-unroller -fsplit-wide-types -fstrict-volatile-bitfields
@ -fsync-libcalls -fthread-jumps -ftoplevel-reorder -ftrapping-math
@ -ftree-bit-ccp -ftree-builtin-call-dce -ftree-ccp -ftree-ch
@ -ftree-coalesce-vars -ftree-copy-prop -ftree-copyrename -ftree-cselim
@ -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
@ -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
@ -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop -ftree-pre
@ -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slsr
@ -ftree-sra -ftree-switch-conversion -ftree-tail-merge -ftree-ter
@ -ftree-vrp -funit-at-a-time -funwind-tables -fuse-caller-save
@ -fverbose-asm -fzero-initialized-in-bss -marm -mglibc -mlittle-endian
@ -mlra -mpic-data-is-text-relative -msched-prolog -munaligned-access
@ -mvectorize-with-neon-quad

	.text
	.align	2
	.global	foo
	.type	foo, %function
foo:
	.fnstart
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
#APP
@ 18 "/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/bounds.c" 1
	
->NR_PAGEFLAGS #22 __NR_PAGEFLAGS	@
@ 0 "" 2
@ 19 "/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/bounds.c" 1
	
->MAX_NR_ZONES #3 __MAX_NR_ZONES	@
@ 0 "" 2
@ 21 "/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/bounds.c" 1
	
->NR_CPUS_BITS #2 ilog2(CONFIG_NR_CPUS)	@
@ 0 "" 2
@ 23 "/opt/pkg/petalinux-v2015.4-final/components/linux-kernel/xlnx-4.0/kernel/bounds.c" 1
	
->SPINLOCK_SIZE #4 sizeof(spinlock_t)	@
@ 0 "" 2
	bx	lr	@
	.fnend
	.size	foo, .-foo
	.ident	"GCC: (Sourcery CodeBench Lite 2015.05-17) 4.9.2"
	.section	.note.GNU-stack,"",%progbits

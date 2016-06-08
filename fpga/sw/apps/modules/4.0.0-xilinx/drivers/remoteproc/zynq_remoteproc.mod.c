#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

MODULE_INFO(intree, "Y");

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x7f374352, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0x62a79a6c, __VMLINUX_SYMBOL_STR(param_ops_charp) },
	{ 0x93984736, __VMLINUX_SYMBOL_STR(platform_driver_unregister) },
	{ 0x4be08338, __VMLINUX_SYMBOL_STR(__platform_driver_register) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x91fc0b81, __VMLINUX_SYMBOL_STR(rproc_add) },
	{ 0x458ec020, __VMLINUX_SYMBOL_STR(rproc_alloc) },
	{ 0x3d622071, __VMLINUX_SYMBOL_STR(of_get_property) },
	{ 0x2215d4f9, __VMLINUX_SYMBOL_STR(set_ipi_handler) },
	{ 0x4e5c6b53, __VMLINUX_SYMBOL_STR(of_property_read_u32_array) },
	{ 0xd6b8e852, __VMLINUX_SYMBOL_STR(request_threaded_irq) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0xeaf9873, __VMLINUX_SYMBOL_STR(platform_get_irq) },
	{ 0x366fc499, __VMLINUX_SYMBOL_STR(dma_supported) },
	{ 0x7ed6f823, __VMLINUX_SYMBOL_STR(dma_declare_coherent_memory) },
	{ 0x37efb476, __VMLINUX_SYMBOL_STR(platform_get_resource) },
	{ 0x4e65c5db, __VMLINUX_SYMBOL_STR(devm_kmalloc) },
	{ 0x7cb1ae69, __VMLINUX_SYMBOL_STR(cpu_down) },
	{ 0x2d3385d3, __VMLINUX_SYMBOL_STR(system_wq) },
	{ 0xb2d48a2e, __VMLINUX_SYMBOL_STR(queue_work_on) },
	{ 0xdce491e3, __VMLINUX_SYMBOL_STR(rproc_vq_interrupt) },
	{ 0x5dcf6341, __VMLINUX_SYMBOL_STR(outer_cache) },
	{ 0x2f4ac89e, __VMLINUX_SYMBOL_STR(zynq_cpun_start) },
	{ 0xe07ca631, __VMLINUX_SYMBOL_STR(cpu_bit_bitmap) },
	{ 0x84bbaba8, __VMLINUX_SYMBOL_STR(gic_raise_softirq) },
	{ 0x56d697ce, __VMLINUX_SYMBOL_STR(cpu_up) },
	{ 0x8019a408, __VMLINUX_SYMBOL_STR(rproc_put) },
	{ 0x4508ff1a, __VMLINUX_SYMBOL_STR(rproc_del) },
	{ 0x99bd722b, __VMLINUX_SYMBOL_STR(clear_ipi_handler) },
	{ 0x7b6f3e69, __VMLINUX_SYMBOL_STR(dma_release_declared_memory) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0xf20dabd8, __VMLINUX_SYMBOL_STR(free_irq) },
	{ 0x7a0befb5, __VMLINUX_SYMBOL_STR(_dev_info) },
	{ 0xdafd2cd3, __VMLINUX_SYMBOL_STR(gic_set_cpu) },
	{ 0x5c4f1a32, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=remoteproc";

MODULE_ALIAS("of:N*T*Cxlnx,zynq_remoteproc*");

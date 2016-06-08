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
	{ 0xdce491e3, __VMLINUX_SYMBOL_STR(rproc_vq_interrupt) },
	{ 0x91fc0b81, __VMLINUX_SYMBOL_STR(rproc_add) },
	{ 0x458ec020, __VMLINUX_SYMBOL_STR(rproc_alloc) },
	{ 0x3d622071, __VMLINUX_SYMBOL_STR(of_get_property) },
	{ 0x12196445, __VMLINUX_SYMBOL_STR(devm_ioremap_resource) },
	{ 0x11d3d4bf, __VMLINUX_SYMBOL_STR(of_find_device_by_node) },
	{ 0x5d401203, __VMLINUX_SYMBOL_STR(of_parse_phandle) },
	{ 0x46a8d2f2, __VMLINUX_SYMBOL_STR(gpiod_to_irq) },
	{ 0x57b14207, __VMLINUX_SYMBOL_STR(devm_gpio_request_one) },
	{ 0x3dcd137b, __VMLINUX_SYMBOL_STR(of_get_named_gpio_flags) },
	{ 0xff0f96a7, __VMLINUX_SYMBOL_STR(devm_request_threaded_irq) },
	{ 0xeaf9873, __VMLINUX_SYMBOL_STR(platform_get_irq) },
	{ 0x366fc499, __VMLINUX_SYMBOL_STR(dma_supported) },
	{ 0x7ed6f823, __VMLINUX_SYMBOL_STR(dma_declare_coherent_memory) },
	{ 0x37efb476, __VMLINUX_SYMBOL_STR(platform_get_resource) },
	{ 0x4e65c5db, __VMLINUX_SYMBOL_STR(devm_kmalloc) },
	{ 0x2d3385d3, __VMLINUX_SYMBOL_STR(system_wq) },
	{ 0xb2d48a2e, __VMLINUX_SYMBOL_STR(queue_work_on) },
	{ 0x5807abb9, __VMLINUX_SYMBOL_STR(release_firmware) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0xd12d393b, __VMLINUX_SYMBOL_STR(request_firmware) },
	{ 0x5dcf6341, __VMLINUX_SYMBOL_STR(outer_cache) },
	{ 0x4298b775, __VMLINUX_SYMBOL_STR(v7_flush_kern_cache_all) },
	{ 0x8e865d3c, __VMLINUX_SYMBOL_STR(arm_delay_ops) },
	{ 0xcd1a6aec, __VMLINUX_SYMBOL_STR(gpiod_set_raw_value) },
	{ 0xe6369f7e, __VMLINUX_SYMBOL_STR(gpio_to_desc) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x5c4f1a32, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0x8019a408, __VMLINUX_SYMBOL_STR(rproc_put) },
	{ 0x4508ff1a, __VMLINUX_SYMBOL_STR(rproc_del) },
	{ 0x7b6f3e69, __VMLINUX_SYMBOL_STR(dma_release_declared_memory) },
	{ 0x7a0befb5, __VMLINUX_SYMBOL_STR(_dev_info) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=remoteproc";

MODULE_ALIAS("of:N*T*Cxlnx,mb_remoteproc*");

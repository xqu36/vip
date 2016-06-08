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
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x2238416d, __VMLINUX_SYMBOL_STR(usb_free_all_descriptors) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0xf7802486, __VMLINUX_SYMBOL_STR(__aeabi_uidivmod) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0x91715312, __VMLINUX_SYMBOL_STR(sprintf) },
	{ 0xfdc79d1c, __VMLINUX_SYMBOL_STR(usb_function_unregister) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0x5f754e5a, __VMLINUX_SYMBOL_STR(memset) },
	{ 0xa1e31a50, __VMLINUX_SYMBOL_STR(usb_put_function_instance) },
	{ 0x5a5a94a6, __VMLINUX_SYMBOL_STR(kstrtou8) },
	{ 0x5c4f1a32, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x774a8d57, __VMLINUX_SYMBOL_STR(usb_ep_autoconfig) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0x87d35cda, __VMLINUX_SYMBOL_STR(config_group_init_type_name) },
	{ 0x8ee3b82f, __VMLINUX_SYMBOL_STR(usb_function_register) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x6a9cdbc9, __VMLINUX_SYMBOL_STR(alloc_ep_req) },
	{ 0x5ac15bae, __VMLINUX_SYMBOL_STR(kstrtou16) },
	{ 0x8db7ecaa, __VMLINUX_SYMBOL_STR(config_ep_by_speed) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0xa46f2f1b, __VMLINUX_SYMBOL_STR(kstrtouint) },
	{ 0x93cc4569, __VMLINUX_SYMBOL_STR(usb_string_id) },
	{ 0x83aad604, __VMLINUX_SYMBOL_STR(usb_assign_descriptors) },
	{ 0x8b2f8473, __VMLINUX_SYMBOL_STR(usb_interface_id) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=libcomposite,configfs";


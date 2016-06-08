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
	{ 0xc996d097, __VMLINUX_SYMBOL_STR(del_timer) },
	{ 0x60ee9172, __VMLINUX_SYMBOL_STR(param_ops_bool) },
	{ 0x593a99b, __VMLINUX_SYMBOL_STR(init_timer_key) },
	{ 0x7d11c268, __VMLINUX_SYMBOL_STR(jiffies) },
	{ 0xebf45d4a, __VMLINUX_SYMBOL_STR(usb_ep_autoconfig_reset) },
	{ 0x62a79a6c, __VMLINUX_SYMBOL_STR(param_ops_charp) },
	{ 0xd5f2172f, __VMLINUX_SYMBOL_STR(del_timer_sync) },
	{ 0xa1e31a50, __VMLINUX_SYMBOL_STR(usb_put_function_instance) },
	{ 0x8834396c, __VMLINUX_SYMBOL_STR(mod_timer) },
	{ 0x5e7cbb7c, __VMLINUX_SYMBOL_STR(usb_composite_overwrite_options) },
	{ 0x7a0befb5, __VMLINUX_SYMBOL_STR(_dev_info) },
	{ 0x561a14c5, __VMLINUX_SYMBOL_STR(usb_composite_probe) },
	{ 0xf3dc644a, __VMLINUX_SYMBOL_STR(usb_add_function) },
	{ 0x3bd1b1f6, __VMLINUX_SYMBOL_STR(msecs_to_jiffies) },
	{ 0xbda65e82, __VMLINUX_SYMBOL_STR(usb_put_function) },
	{ 0x20291757, __VMLINUX_SYMBOL_STR(usb_composite_unregister) },
	{ 0x527780d, __VMLINUX_SYMBOL_STR(usb_get_function) },
	{ 0x25eb40cb, __VMLINUX_SYMBOL_STR(usb_string_ids_tab) },
	{ 0x65867f42, __VMLINUX_SYMBOL_STR(usb_add_config_only) },
	{ 0x107e236d, __VMLINUX_SYMBOL_STR(usb_get_function_instance) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0xb225bf0d, __VMLINUX_SYMBOL_STR(param_ops_ushort) },
	{ 0x149c7752, __VMLINUX_SYMBOL_STR(param_ops_uint) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=libcomposite";


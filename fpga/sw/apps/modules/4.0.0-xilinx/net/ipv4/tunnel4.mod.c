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
	{ 0x609f1c7e, __VMLINUX_SYMBOL_STR(synchronize_net) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0xe4ba176d, __VMLINUX_SYMBOL_STR(icmp_send) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0xd37f3205, __VMLINUX_SYMBOL_STR(inet_del_protocol) },
	{ 0x65b8fb23, __VMLINUX_SYMBOL_STR(__pskb_pull_tail) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0xf3b697b9, __VMLINUX_SYMBOL_STR(inet_add_protocol) },
	{ 0x340ebda9, __VMLINUX_SYMBOL_STR(kfree_skb) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


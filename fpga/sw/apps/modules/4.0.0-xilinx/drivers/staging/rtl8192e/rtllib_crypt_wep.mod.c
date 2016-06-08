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

MODULE_INFO(staging, "Y");

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x7f374352, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0x23471cc4, __VMLINUX_SYMBOL_STR(lib80211_unregister_crypto_ops) },
	{ 0xa0aa4e54, __VMLINUX_SYMBOL_STR(lib80211_register_crypto_ops) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x79aa04a2, __VMLINUX_SYMBOL_STR(get_random_bytes) },
	{ 0x74399a23, __VMLINUX_SYMBOL_STR(crypto_alloc_base) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0xb198669c, __VMLINUX_SYMBOL_STR(crypto_destroy_tfm) },
	{ 0x1de26a24, __VMLINUX_SYMBOL_STR(skb_put) },
	{ 0xfd0498c, __VMLINUX_SYMBOL_STR(skb_push) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x71c90087, __VMLINUX_SYMBOL_STR(memcmp) },
	{ 0x6220b4a2, __VMLINUX_SYMBOL_STR(crc32_le) },
	{ 0xefdd2345, __VMLINUX_SYMBOL_STR(sg_init_one) },
	{ 0x14642c91, __VMLINUX_SYMBOL_STR(skb_trim) },
	{ 0x796ce594, __VMLINUX_SYMBOL_STR(skb_pull) },
	{ 0x99bb8806, __VMLINUX_SYMBOL_STR(memmove) },
	{ 0x5f754e5a, __VMLINUX_SYMBOL_STR(memset) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0x3ff95042, __VMLINUX_SYMBOL_STR(seq_printf) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=lib80211";


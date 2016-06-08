#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.arch = MODULE_ARCH_INIT,
};

MODULE_INFO(intree, "Y");

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x7f374352, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x31100d8c, __VMLINUX_SYMBOL_STR(rtl_deinit_deferred_work) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0xbd8ddcb9, __VMLINUX_SYMBOL_STR(rtl_deinit_core) },
	{ 0x97f52ad6, __VMLINUX_SYMBOL_STR(usb_get_from_anchor) },
	{ 0x4205ad24, __VMLINUX_SYMBOL_STR(cancel_work_sync) },
	{ 0xe2fae716, __VMLINUX_SYMBOL_STR(kmemdup) },
	{ 0x58fc8b04, __VMLINUX_SYMBOL_STR(ieee80211_unregister_hw) },
	{ 0x1bd8854a, __VMLINUX_SYMBOL_STR(__dev_kfree_skb_any) },
	{ 0x6996581d, __VMLINUX_SYMBOL_STR(usb_unanchor_urb) },
	{ 0x9433b251, __VMLINUX_SYMBOL_STR(__netdev_alloc_skb) },
	{ 0x275ef902, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0x1fab5905, __VMLINUX_SYMBOL_STR(wait_for_completion) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0xd68fd528, __VMLINUX_SYMBOL_STR(skb_queue_purge) },
	{ 0x5f754e5a, __VMLINUX_SYMBOL_STR(memset) },
	{ 0x51d559d1, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irqrestore) },
	{ 0x8d47eebe, __VMLINUX_SYMBOL_STR(ieee80211_alloc_hw_nm) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xcc6787da, __VMLINUX_SYMBOL_STR(rtl_init_core) },
	{ 0xfaef0ed, __VMLINUX_SYMBOL_STR(__tasklet_schedule) },
	{ 0xf98063dd, __VMLINUX_SYMBOL_STR(rtl_action_proc) },
	{ 0xce4f7d63, __VMLINUX_SYMBOL_STR(rtl_dbgp_flag_init) },
	{ 0x20347c69, __VMLINUX_SYMBOL_STR(usb_control_msg) },
	{ 0xf0fa2d92, __VMLINUX_SYMBOL_STR(ieee80211_rx) },
	{ 0xf8ff6add, __VMLINUX_SYMBOL_STR(rtl_lps_change_work_callback) },
	{ 0xa499fe1, __VMLINUX_SYMBOL_STR(rtl_init_rx_config) },
	{ 0x796ce594, __VMLINUX_SYMBOL_STR(skb_pull) },
	{ 0xc3ca6624, __VMLINUX_SYMBOL_STR(usb_free_coherent) },
	{ 0x82072614, __VMLINUX_SYMBOL_STR(tasklet_kill) },
	{ 0xadc0a361, __VMLINUX_SYMBOL_STR(skb_queue_tail) },
	{ 0xcb717fef, __VMLINUX_SYMBOL_STR(usb_submit_urb) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x59e95a49, __VMLINUX_SYMBOL_STR(usb_get_dev) },
	{ 0xd1f0a011, __VMLINUX_SYMBOL_STR(usb_kill_anchored_urbs) },
	{ 0xd0f1725c, __VMLINUX_SYMBOL_STR(usb_put_dev) },
	{ 0xbdab90cc, __VMLINUX_SYMBOL_STR(ieee80211_tx_status_irqsafe) },
	{ 0x998ffd35, __VMLINUX_SYMBOL_STR(rtl_ops) },
	{ 0x340ebda9, __VMLINUX_SYMBOL_STR(kfree_skb) },
	{ 0x598542b2, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irqsave) },
	{ 0xa46e6768, __VMLINUX_SYMBOL_STR(ieee80211_register_hw) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0xbfacf0a, __VMLINUX_SYMBOL_STR(rtl_ips_nic_on) },
	{ 0x90a6df91, __VMLINUX_SYMBOL_STR(ieee80211_free_hw) },
	{ 0xd70dd9, __VMLINUX_SYMBOL_STR(skb_dequeue) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0x676bbc0f, __VMLINUX_SYMBOL_STR(_set_bit) },
	{ 0xd4669fad, __VMLINUX_SYMBOL_STR(complete) },
	{ 0xca54fee, __VMLINUX_SYMBOL_STR(_test_and_set_bit) },
	{ 0x818ca2e, __VMLINUX_SYMBOL_STR(usb_alloc_coherent) },
	{ 0x1de26a24, __VMLINUX_SYMBOL_STR(skb_put) },
	{ 0xb83435d7, __VMLINUX_SYMBOL_STR(usb_free_urb) },
	{ 0x5dace859, __VMLINUX_SYMBOL_STR(rtl_beacon_statistic) },
	{ 0x47c30b91, __VMLINUX_SYMBOL_STR(usb_anchor_urb) },
	{ 0xff096f19, __VMLINUX_SYMBOL_STR(usb_alloc_urb) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=rtlwifi";


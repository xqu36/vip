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
	{ 0x41a53b94, __VMLINUX_SYMBOL_STR(register_netdevice) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0xfbc74f64, __VMLINUX_SYMBOL_STR(__copy_from_user) },
	{ 0xdbf4e116, __VMLINUX_SYMBOL_STR(dev_change_flags) },
	{ 0xce0a01e1, __VMLINUX_SYMBOL_STR(dev_mc_unsync) },
	{ 0x89a90628, __VMLINUX_SYMBOL_STR(single_open) },
	{ 0x67c2fa54, __VMLINUX_SYMBOL_STR(__copy_to_user) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x60a13e90, __VMLINUX_SYMBOL_STR(rcu_barrier) },
	{ 0x6d805693, __VMLINUX_SYMBOL_STR(dev_get_nest_level) },
	{ 0xe9ee004a, __VMLINUX_SYMBOL_STR(vlan_dev_vlan_id) },
	{ 0x375a9c49, __VMLINUX_SYMBOL_STR(dev_uc_add) },
	{ 0x4608fe6, __VMLINUX_SYMBOL_STR(single_release) },
	{ 0xe2752b5c, __VMLINUX_SYMBOL_STR(seq_puts) },
	{ 0xc7a4fbed, __VMLINUX_SYMBOL_STR(rtnl_lock) },
	{ 0x3fb9b609, __VMLINUX_SYMBOL_STR(vlan_uses_dev) },
	{ 0x6d3880f6, __VMLINUX_SYMBOL_STR(netif_carrier_on) },
	{ 0xd3f57a2, __VMLINUX_SYMBOL_STR(_find_next_bit_le) },
	{ 0x3ff95042, __VMLINUX_SYMBOL_STR(seq_printf) },
	{ 0xd2da1048, __VMLINUX_SYMBOL_STR(register_netdevice_notifier) },
	{ 0xfe1d981c, __VMLINUX_SYMBOL_STR(netif_carrier_off) },
	{ 0x8a461664, __VMLINUX_SYMBOL_STR(remove_proc_entry) },
	{ 0x50c89f23, __VMLINUX_SYMBOL_STR(__alloc_percpu) },
	{ 0xfae70a15, __VMLINUX_SYMBOL_STR(dev_set_allmulti) },
	{ 0x7319fd7f, __VMLINUX_SYMBOL_STR(vlan_vid_del) },
	{ 0x92dd33e1, __VMLINUX_SYMBOL_STR(call_netdevice_notifiers) },
	{ 0x6134bb31, __VMLINUX_SYMBOL_STR(linkwatch_fire_event) },
	{ 0xbb62e258, __VMLINUX_SYMBOL_STR(vlan_vid_add) },
	{ 0x7cf5dcfe, __VMLINUX_SYMBOL_STR(__netpoll_setup) },
	{ 0x4818d2f4, __VMLINUX_SYMBOL_STR(seq_read) },
	{ 0xc9ec4e21, __VMLINUX_SYMBOL_STR(free_percpu) },
	{ 0x9d0d6206, __VMLINUX_SYMBOL_STR(unregister_netdevice_notifier) },
	{ 0xe2d5255a, __VMLINUX_SYMBOL_STR(strcmp) },
	{ 0x11e27cf3, __VMLINUX_SYMBOL_STR(proc_remove) },
	{ 0x6bd2930c, __VMLINUX_SYMBOL_STR(vlan_ioctl_set) },
	{ 0xf2030286, __VMLINUX_SYMBOL_STR(netpoll_send_skb_on_dev) },
	{ 0xf21c80fb, __VMLINUX_SYMBOL_STR(PDE_DATA) },
	{ 0xfe7c4287, __VMLINUX_SYMBOL_STR(nr_cpu_ids) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0x8f9d34d4, __VMLINUX_SYMBOL_STR(unregister_pernet_subsys) },
	{ 0x9fdecc31, __VMLINUX_SYMBOL_STR(unregister_netdevice_many) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xc81d80ca, __VMLINUX_SYMBOL_STR(ethtool_op_get_link) },
	{ 0x5c54b7e6, __VMLINUX_SYMBOL_STR(ns_capable) },
	{ 0x7cd2b6c4, __VMLINUX_SYMBOL_STR(__netpoll_free_async) },
	{ 0x3c64d4c0, __VMLINUX_SYMBOL_STR(__ethtool_get_settings) },
	{ 0x9da45ad3, __VMLINUX_SYMBOL_STR(free_netdev) },
	{ 0x328a05f1, __VMLINUX_SYMBOL_STR(strncpy) },
	{ 0x17fcc2e7, __VMLINUX_SYMBOL_STR(nla_put) },
	{ 0xd5353c6c, __VMLINUX_SYMBOL_STR(netdev_upper_dev_unlink) },
	{ 0x73e20c1c, __VMLINUX_SYMBOL_STR(strlcpy) },
	{ 0xfd0498c, __VMLINUX_SYMBOL_STR(skb_push) },
	{ 0x3db7af66, __VMLINUX_SYMBOL_STR(proc_mkdir_data) },
	{ 0xc16e048, __VMLINUX_SYMBOL_STR(seq_release_net) },
	{ 0xdc9313c2, __VMLINUX_SYMBOL_STR(netif_stacked_transfer_operstate) },
	{ 0x2469810f, __VMLINUX_SYMBOL_STR(__rcu_read_unlock) },
	{ 0x7c31bce5, __VMLINUX_SYMBOL_STR(init_net) },
	{ 0x159c11a7, __VMLINUX_SYMBOL_STR(rtnl_link_unregister) },
	{ 0x9bde61c2, __VMLINUX_SYMBOL_STR(__dev_get_by_index) },
	{ 0x347013de, __VMLINUX_SYMBOL_STR(nla_validate) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x7c7afe63, __VMLINUX_SYMBOL_STR(arp_find) },
	{ 0xd3e6f60d, __VMLINUX_SYMBOL_STR(cpu_possible_mask) },
	{ 0xf717c40b, __VMLINUX_SYMBOL_STR(eth_header_parse) },
	{ 0x6b2dc060, __VMLINUX_SYMBOL_STR(dump_stack) },
	{ 0x5dfcbcf4, __VMLINUX_SYMBOL_STR(alloc_netdev_mqs) },
	{ 0x1b93945d, __VMLINUX_SYMBOL_STR(register_pernet_subsys) },
	{ 0x5e574cca, __VMLINUX_SYMBOL_STR(netdev_upper_dev_link) },
	{ 0xaa6c67b9, __VMLINUX_SYMBOL_STR(ether_setup) },
	{ 0x9cc039d5, __VMLINUX_SYMBOL_STR(dev_uc_unsync) },
	{ 0xf63393b7, __VMLINUX_SYMBOL_STR(__dev_get_by_name) },
	{ 0x341dbfa3, __VMLINUX_SYMBOL_STR(__per_cpu_offset) },
	{ 0x389ffa40, __VMLINUX_SYMBOL_STR(unregister_netdevice_queue) },
	{ 0x4e72fb04, __VMLINUX_SYMBOL_STR(netdev_warn) },
	{ 0xc9c87b9b, __VMLINUX_SYMBOL_STR(proc_create_data) },
	{ 0xfd132f55, __VMLINUX_SYMBOL_STR(eth_validate_addr) },
	{ 0x8dcf8389, __VMLINUX_SYMBOL_STR(seq_lseek) },
	{ 0x998b11f6, __VMLINUX_SYMBOL_STR(dev_set_promiscuity) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x83a422bf, __VMLINUX_SYMBOL_STR(seq_open_net) },
	{ 0x7827e858, __VMLINUX_SYMBOL_STR(rtnl_link_register) },
	{ 0xcba1c4ff, __VMLINUX_SYMBOL_STR(dev_uc_del) },
	{ 0x1073d99b, __VMLINUX_SYMBOL_STR(dev_uc_sync) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0xb81960ca, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0xbfef431c, __VMLINUX_SYMBOL_STR(netdev_update_features) },
	{ 0x85670f1d, __VMLINUX_SYMBOL_STR(rtnl_is_locked) },
	{ 0xe1a80c82, __VMLINUX_SYMBOL_STR(dev_queue_xmit) },
	{ 0x8d522714, __VMLINUX_SYMBOL_STR(__rcu_read_lock) },
	{ 0xad0018b8, __VMLINUX_SYMBOL_STR(dev_mc_sync) },
	{ 0x6e720ff2, __VMLINUX_SYMBOL_STR(rtnl_unlock) },
	{ 0xfadf2b41, __VMLINUX_SYMBOL_STR(dev_get_stats) },
	{ 0x61efc657, __VMLINUX_SYMBOL_STR(dev_set_mtu) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "7E9F42FA57AE89FD39C1892");

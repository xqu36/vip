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
	{ 0xaaee2bf9, __VMLINUX_SYMBOL_STR(ip_tunnel_get_link_net) },
	{ 0x60ee9172, __VMLINUX_SYMBOL_STR(param_ops_bool) },
	{ 0xeeedd469, __VMLINUX_SYMBOL_STR(ip_tunnel_get_stats64) },
	{ 0x7827e858, __VMLINUX_SYMBOL_STR(rtnl_link_register) },
	{ 0x5facbd6b, __VMLINUX_SYMBOL_STR(xfrm4_tunnel_register) },
	{ 0xd87ff2a8, __VMLINUX_SYMBOL_STR(register_pernet_device) },
	{ 0x60a13e90, __VMLINUX_SYMBOL_STR(rcu_barrier) },
	{ 0x4c715221, __VMLINUX_SYMBOL_STR(unregister_pernet_device) },
	{ 0x99568e03, __VMLINUX_SYMBOL_STR(xfrm4_tunnel_deregister) },
	{ 0x159c11a7, __VMLINUX_SYMBOL_STR(rtnl_link_unregister) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x9469482, __VMLINUX_SYMBOL_STR(kfree_call_rcu) },
	{ 0xbc10dd97, __VMLINUX_SYMBOL_STR(__put_user_4) },
	{ 0x12da5bb2, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0xc6cbbc89, __VMLINUX_SYMBOL_STR(capable) },
	{ 0x67c2fa54, __VMLINUX_SYMBOL_STR(__copy_to_user) },
	{ 0x5c54b7e6, __VMLINUX_SYMBOL_STR(ns_capable) },
	{ 0xfbc74f64, __VMLINUX_SYMBOL_STR(__copy_from_user) },
	{ 0xc82c683e, __VMLINUX_SYMBOL_STR(ipv6_chk_prefix) },
	{ 0x58acb231, __VMLINUX_SYMBOL_STR(netif_rx) },
	{ 0xa92f04a8, __VMLINUX_SYMBOL_STR(skb_scrub_packet) },
	{ 0x8f809fdd, __VMLINUX_SYMBOL_STR(ipv6_chk_custom_prefix) },
	{ 0xabfb608f, __VMLINUX_SYMBOL_STR(sock_wfree) },
	{ 0x4de6de29, __VMLINUX_SYMBOL_STR(iptunnel_xmit) },
	{ 0xcbb86785, __VMLINUX_SYMBOL_STR(ip_tunnel_encap) },
	{ 0xeabc3fe3, __VMLINUX_SYMBOL_STR(consume_skb) },
	{ 0x6b73984c, __VMLINUX_SYMBOL_STR(skb_realloc_headroom) },
	{ 0x2e8f93ca, __VMLINUX_SYMBOL_STR(neigh_destroy) },
	{ 0xd542439, __VMLINUX_SYMBOL_STR(__ipv6_addr_type) },
	{ 0xf6ebc03b, __VMLINUX_SYMBOL_STR(net_ratelimit) },
	{ 0x5f4df3ed, __VMLINUX_SYMBOL_STR(ip_tunnel_xmit) },
	{ 0xca779bb3, __VMLINUX_SYMBOL_STR(iptunnel_handle_offloads) },
	{ 0x22c45985, __VMLINUX_SYMBOL_STR(netdev_state_change) },
	{ 0x609f1c7e, __VMLINUX_SYMBOL_STR(synchronize_net) },
	{ 0x5880b9ad, __VMLINUX_SYMBOL_STR(ip_tunnel_dst_reset_all) },
	{ 0x32ddd5b6, __VMLINUX_SYMBOL_STR(call_rcu) },
	{ 0x6b2dc060, __VMLINUX_SYMBOL_STR(dump_stack) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x85670f1d, __VMLINUX_SYMBOL_STR(rtnl_is_locked) },
	{ 0x7d11c268, __VMLINUX_SYMBOL_STR(jiffies) },
	{ 0xf12836ee, __VMLINUX_SYMBOL_STR(icmpv6_send) },
	{ 0x7f62b673, __VMLINUX_SYMBOL_STR(rt6_lookup) },
	{ 0x796ce594, __VMLINUX_SYMBOL_STR(skb_pull) },
	{ 0x65b8fb23, __VMLINUX_SYMBOL_STR(__pskb_pull_tail) },
	{ 0xb9d9488b, __VMLINUX_SYMBOL_STR(skb_clone) },
	{ 0x51a779f9, __VMLINUX_SYMBOL_STR(ipv4_redirect) },
	{ 0xe9a021ee, __VMLINUX_SYMBOL_STR(ipv4_update_pmtu) },
	{ 0xe551d07d, __VMLINUX_SYMBOL_STR(ip_tunnel_rcv) },
	{ 0xfa769bad, __VMLINUX_SYMBOL_STR(iptunnel_pull_header) },
	{ 0x340ebda9, __VMLINUX_SYMBOL_STR(kfree_skb) },
	{ 0x5bd2e49a, __VMLINUX_SYMBOL_STR(__xfrm_policy_check) },
	{ 0x77eb1e5c, __VMLINUX_SYMBOL_STR(register_netdev) },
	{ 0x6e720ff2, __VMLINUX_SYMBOL_STR(rtnl_unlock) },
	{ 0x9fdecc31, __VMLINUX_SYMBOL_STR(unregister_netdevice_many) },
	{ 0xc7a4fbed, __VMLINUX_SYMBOL_STR(rtnl_lock) },
	{ 0x341dbfa3, __VMLINUX_SYMBOL_STR(__per_cpu_offset) },
	{ 0xfe7c4287, __VMLINUX_SYMBOL_STR(nr_cpu_ids) },
	{ 0xd3e6f60d, __VMLINUX_SYMBOL_STR(cpu_possible_mask) },
	{ 0xd3f57a2, __VMLINUX_SYMBOL_STR(_find_next_bit_le) },
	{ 0x50c89f23, __VMLINUX_SYMBOL_STR(__alloc_percpu) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9bde61c2, __VMLINUX_SYMBOL_STR(__dev_get_by_index) },
	{ 0x5e9b0d4c, __VMLINUX_SYMBOL_STR(dst_release) },
	{ 0xcc84d44, __VMLINUX_SYMBOL_STR(ip_route_output_flow) },
	{ 0x2d5999c4, __VMLINUX_SYMBOL_STR(ip_tunnel_encap_setup) },
	{ 0x5dfcbcf4, __VMLINUX_SYMBOL_STR(alloc_netdev_mqs) },
	{ 0xe914e41e, __VMLINUX_SYMBOL_STR(strcpy) },
	{ 0x73e20c1c, __VMLINUX_SYMBOL_STR(strlcpy) },
	{ 0x9da45ad3, __VMLINUX_SYMBOL_STR(free_netdev) },
	{ 0xc9ec4e21, __VMLINUX_SYMBOL_STR(free_percpu) },
	{ 0x41a53b94, __VMLINUX_SYMBOL_STR(register_netdevice) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0x7c31bce5, __VMLINUX_SYMBOL_STR(init_net) },
	{ 0x389ffa40, __VMLINUX_SYMBOL_STR(unregister_netdevice_queue) },
	{ 0x2469810f, __VMLINUX_SYMBOL_STR(__rcu_read_unlock) },
	{ 0x8d522714, __VMLINUX_SYMBOL_STR(__rcu_read_lock) },
	{ 0x17fcc2e7, __VMLINUX_SYMBOL_STR(nla_put) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=ip_tunnel,tunnel4,ipv6";


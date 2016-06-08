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
	{ 0x166e00db, __VMLINUX_SYMBOL_STR(ip_tunnel_dellink) },
	{ 0x60ee9172, __VMLINUX_SYMBOL_STR(param_ops_bool) },
	{ 0xeeedd469, __VMLINUX_SYMBOL_STR(ip_tunnel_get_stats64) },
	{ 0x4703afc, __VMLINUX_SYMBOL_STR(ip_tunnel_change_mtu) },
	{ 0x6db313dd, __VMLINUX_SYMBOL_STR(ip_tunnel_uninit) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x159c11a7, __VMLINUX_SYMBOL_STR(rtnl_link_unregister) },
	{ 0x4c715221, __VMLINUX_SYMBOL_STR(unregister_pernet_device) },
	{ 0x99568e03, __VMLINUX_SYMBOL_STR(xfrm4_tunnel_deregister) },
	{ 0x7827e858, __VMLINUX_SYMBOL_STR(rtnl_link_register) },
	{ 0x5facbd6b, __VMLINUX_SYMBOL_STR(xfrm4_tunnel_register) },
	{ 0xd87ff2a8, __VMLINUX_SYMBOL_STR(register_pernet_device) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xc5cc5146, __VMLINUX_SYMBOL_STR(ip_tunnel_init_net) },
	{ 0x2e52ea01, __VMLINUX_SYMBOL_STR(ip_tunnel_delete_net) },
	{ 0xe551d07d, __VMLINUX_SYMBOL_STR(ip_tunnel_rcv) },
	{ 0xfa769bad, __VMLINUX_SYMBOL_STR(iptunnel_pull_header) },
	{ 0x5bd2e49a, __VMLINUX_SYMBOL_STR(__xfrm_policy_check) },
	{ 0x7d11c268, __VMLINUX_SYMBOL_STR(jiffies) },
	{ 0x7c31bce5, __VMLINUX_SYMBOL_STR(init_net) },
	{ 0x51a779f9, __VMLINUX_SYMBOL_STR(ipv4_redirect) },
	{ 0xe9a021ee, __VMLINUX_SYMBOL_STR(ipv4_update_pmtu) },
	{ 0xd686fa3b, __VMLINUX_SYMBOL_STR(ip_tunnel_lookup) },
	{ 0x2469810f, __VMLINUX_SYMBOL_STR(__rcu_read_unlock) },
	{ 0x8d522714, __VMLINUX_SYMBOL_STR(__rcu_read_lock) },
	{ 0xc58b1bbf, __VMLINUX_SYMBOL_STR(ip_tunnel_init) },
	{ 0x340ebda9, __VMLINUX_SYMBOL_STR(kfree_skb) },
	{ 0x5f4df3ed, __VMLINUX_SYMBOL_STR(ip_tunnel_xmit) },
	{ 0xca779bb3, __VMLINUX_SYMBOL_STR(iptunnel_handle_offloads) },
	{ 0x67c2fa54, __VMLINUX_SYMBOL_STR(__copy_to_user) },
	{ 0xc37b599f, __VMLINUX_SYMBOL_STR(ip_tunnel_ioctl) },
	{ 0xfbc74f64, __VMLINUX_SYMBOL_STR(__copy_from_user) },
	{ 0x53533d5b, __VMLINUX_SYMBOL_STR(ip_tunnel_setup) },
	{ 0xd6860e9e, __VMLINUX_SYMBOL_STR(ip_tunnel_newlink) },
	{ 0x3dd0bc48, __VMLINUX_SYMBOL_STR(ip_tunnel_changelink) },
	{ 0x2d5999c4, __VMLINUX_SYMBOL_STR(ip_tunnel_encap_setup) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0x17fcc2e7, __VMLINUX_SYMBOL_STR(nla_put) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=ip_tunnel,tunnel4";


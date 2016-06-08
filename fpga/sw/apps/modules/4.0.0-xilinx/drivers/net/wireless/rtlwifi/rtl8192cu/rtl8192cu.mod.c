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
	{ 0xc0df3a5d, __VMLINUX_SYMBOL_STR(rtl_cam_delete_one_entry) },
	{ 0x2d3385d3, __VMLINUX_SYMBOL_STR(system_wq) },
	{ 0x1e1276c4, __VMLINUX_SYMBOL_STR(rtl_fw_cb) },
	{ 0xd338f25d, __VMLINUX_SYMBOL_STR(rtl_cam_get_free_entry) },
	{ 0xb5e41ba7, __VMLINUX_SYMBOL_STR(rtl92c_phy_set_rfpath_switch) },
	{ 0x8b516040, __VMLINUX_SYMBOL_STR(rtl_usb_disconnect) },
	{ 0x4f7e14d4, __VMLINUX_SYMBOL_STR(_rtl92c_phy_fw_rf_serial_read) },
	{ 0x51eafc8e, __VMLINUX_SYMBOL_STR(param_ops_int) },
	{ 0x8d885c69, __VMLINUX_SYMBOL_STR(rtl92c_phy_set_txpower_level) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x29d20555, __VMLINUX_SYMBOL_STR(rtl92c_set_fw_rsvdpagepkt) },
	{ 0x319fa0f, __VMLINUX_SYMBOL_STR(rtl92c_dm_check_txpower_tracking) },
	{ 0xfa2fe35c, __VMLINUX_SYMBOL_STR(rtl_ps_disable_nic) },
	{ 0x64b53db2, __VMLINUX_SYMBOL_STR(rtl92c_dm_watchdog) },
	{ 0x363e1c92, __VMLINUX_SYMBOL_STR(_rtl92c_phy_init_bb_rf_register_definition) },
	{ 0x57686490, __VMLINUX_SYMBOL_STR(_rtl92c_phy_rf_serial_write) },
	{ 0xfa7f6efc, __VMLINUX_SYMBOL_STR(rtl_get_tcb_desc) },
	{ 0xf7802486, __VMLINUX_SYMBOL_STR(__aeabi_uidivmod) },
	{ 0x6a128fe0, __VMLINUX_SYMBOL_STR(_rtl92c_phy_rf_serial_read) },
	{ 0xe67c44e3, __VMLINUX_SYMBOL_STR(rtl92c_phy_set_bw_mode) },
	{ 0x2db500f0, __VMLINUX_SYMBOL_STR(rtl92c_phy_lc_calibrate) },
	{ 0xb3314d48, __VMLINUX_SYMBOL_STR(_rtl92c_phy_calculate_bit_shift) },
	{ 0x5f66bc77, __VMLINUX_SYMBOL_STR(rtl_efuse_shadow_map_update) },
	{ 0x60ee9172, __VMLINUX_SYMBOL_STR(param_ops_bool) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0x5b41ae8, __VMLINUX_SYMBOL_STR(rtl_cam_add_one_entry) },
	{ 0x999e8297, __VMLINUX_SYMBOL_STR(vfree) },
	{ 0x7d11c268, __VMLINUX_SYMBOL_STR(jiffies) },
	{ 0x292aacb2, __VMLINUX_SYMBOL_STR(rtl_phy_scan_operation_backup) },
	{ 0x99598b7e, __VMLINUX_SYMBOL_STR(rtl92c_dm_init_edca_turbo) },
	{ 0x316e5523, __VMLINUX_SYMBOL_STR(rtl92c_phy_iq_calibrate) },
	{ 0x26494e67, __VMLINUX_SYMBOL_STR(rtl92c_dm_init) },
	{ 0x3ea457a2, __VMLINUX_SYMBOL_STR(rtl_usb_probe) },
	{ 0xe707d823, __VMLINUX_SYMBOL_STR(__aeabi_uidiv) },
	{ 0x12d6949d, __VMLINUX_SYMBOL_STR(rtl92c_phy_set_bb_reg) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0x5f754e5a, __VMLINUX_SYMBOL_STR(memset) },
	{ 0x735ed151, __VMLINUX_SYMBOL_STR(rtl_ps_enable_nic) },
	{ 0x51d559d1, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irqrestore) },
	{ 0x37befc70, __VMLINUX_SYMBOL_STR(jiffies_to_msecs) },
	{ 0xa4b73c35, __VMLINUX_SYMBOL_STR(usb_deregister) },
	{ 0x34908c14, __VMLINUX_SYMBOL_STR(print_hex_dump_bytes) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x894ffff1, __VMLINUX_SYMBOL_STR(rtl92c_dm_rf_saving) },
	{ 0xcb72e282, __VMLINUX_SYMBOL_STR(rtl92c_set_fw_pwrmode_cmd) },
	{ 0xf0fa2d92, __VMLINUX_SYMBOL_STR(ieee80211_rx) },
	{ 0x11548e76, __VMLINUX_SYMBOL_STR(dm_writepowerindex) },
	{ 0xfd0498c, __VMLINUX_SYMBOL_STR(skb_push) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0x2469810f, __VMLINUX_SYMBOL_STR(__rcu_read_unlock) },
	{ 0x800989a6, __VMLINUX_SYMBOL_STR(_rtl92c_phy_fw_rf_serial_write) },
	{ 0x8e865d3c, __VMLINUX_SYMBOL_STR(arm_delay_ops) },
	{ 0x796ce594, __VMLINUX_SYMBOL_STR(skb_pull) },
	{ 0x32543e7b, __VMLINUX_SYMBOL_STR(_rtl92c_phy_set_rf_sleep) },
	{ 0xcb0b902d, __VMLINUX_SYMBOL_STR(request_firmware_nowait) },
	{ 0x2196324, __VMLINUX_SYMBOL_STR(__aeabi_idiv) },
	{ 0xb091b55a, __VMLINUX_SYMBOL_STR(rtlwifi_rate_mapping) },
	{ 0xdc7cfa49, __VMLINUX_SYMBOL_STR(rtl92c_set_fw_joinbss_report_cmd) },
	{ 0xc251d5c5, __VMLINUX_SYMBOL_STR(rtl92c_download_fw) },
	{ 0x40a9b349, __VMLINUX_SYMBOL_STR(vzalloc) },
	{ 0xfba1e177, __VMLINUX_SYMBOL_STR(rtl_rfreg_delay) },
	{ 0x9f82cb9d, __VMLINUX_SYMBOL_STR(rtl92c_phy_set_io_cmd) },
	{ 0xfcf5b186, __VMLINUX_SYMBOL_STR(ieee80211_find_sta) },
	{ 0x598542b2, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irqsave) },
	{ 0x1f83587f, __VMLINUX_SYMBOL_STR(rtl_cam_mark_invalid) },
	{ 0x366915f5, __VMLINUX_SYMBOL_STR(rtl92c_phy_rf_config) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0xcd2a8de3, __VMLINUX_SYMBOL_STR(rtl_cam_del_entry) },
	{ 0xa7d2d8a2, __VMLINUX_SYMBOL_STR(rtl_cam_empty_entry) },
	{ 0x316a3f15, __VMLINUX_SYMBOL_STR(rtl92ce_phy_set_rf_on) },
	{ 0x7cecdd7d, __VMLINUX_SYMBOL_STR(usb_register_driver) },
	{ 0xda34a2a3, __VMLINUX_SYMBOL_STR(rtl92c_phy_query_bb_reg) },
	{ 0x3754c4f9, __VMLINUX_SYMBOL_STR(_rtl92c_store_pwrIndex_diffrate_offset) },
	{ 0xd70dd9, __VMLINUX_SYMBOL_STR(skb_dequeue) },
	{ 0xb0e58b2c, __VMLINUX_SYMBOL_STR(rtl_cam_reset_all_entry) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0xb2d48a2e, __VMLINUX_SYMBOL_STR(queue_work_on) },
	{ 0x8d522714, __VMLINUX_SYMBOL_STR(__rcu_read_lock) },
	{ 0xc768a452, __VMLINUX_SYMBOL_STR(rtl_process_phyinfo) },
	{ 0xaa76c0c4, __VMLINUX_SYMBOL_STR(dm_restorepowerindex) },
	{ 0xc61d7e13, __VMLINUX_SYMBOL_STR(efuse_read_1byte) },
	{ 0x4e0ebc4b, __VMLINUX_SYMBOL_STR(_rtl92c_phy_bb8192c_config_parafile) },
	{ 0x6c3477c8, __VMLINUX_SYMBOL_STR(rtl92c_fill_h2c_cmd) },
	{ 0x6663078b, __VMLINUX_SYMBOL_STR(rtl92c_phy_sw_chnl) },
	{ 0x980848e2, __VMLINUX_SYMBOL_STR(rtl_addr_delay) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=rtlwifi,rtl8192c-common,rtl_usb";

MODULE_ALIAS("usb:v0BDAp8191d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp018Ad*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp8170d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp8176d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp8177d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp817Ad*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp817Bd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp817Dd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp817Ed*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp817Fd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp818Ad*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp819Ad*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp8754d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp8178d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp817Cd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v050Dp1102d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v050Dp11F2d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v06F8pE033d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v07B8p8188d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v07B8p8189d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0846p9041d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp5088d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0DF6p0052d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0DF6p005Cd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0DF6p0070d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0DF6p0077d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0EB0p9071d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v4856p0091d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v103Cp1629d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v13D3p3357d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2001p3308d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2019p4902d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2019pAB2Ad*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2019pAB2Ed*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2019pED17d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v20F4p648Bd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v7392p7811d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v13D3p3358d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v13D3p3359d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v4855p0090d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v4855p0091d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v9846p9041d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp317Fd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v04F2pAFF7d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v04F2pAFF9d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v04F2pAFFAd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v04F2pAFF8d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v04F2pAFFBd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v04F2pAFFCd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2019p1201d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v050Dp1004d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v050Dp2102d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v050Dp2103d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0586p341Fd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v07AAp0056d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v07B8p8178d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0846p9021d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0846pF001d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0B05p17ABd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0BDAp8186d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0DF6p0061d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v0E66p0019d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2001p3307d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2001p3309d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2001p330Ad*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2019pAB2Bd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v20F4p624Dd*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2357p0100d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v7392p7822d*dc*dsc*dp*ic*isc*ip*in*");

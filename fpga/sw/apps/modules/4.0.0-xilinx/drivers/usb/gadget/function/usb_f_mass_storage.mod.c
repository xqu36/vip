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
	{ 0x2e68ca71, __VMLINUX_SYMBOL_STR(d_path) },
	{ 0xa8232c78, __VMLINUX_SYMBOL_STR(strtobool) },
	{ 0x2ba31300, __VMLINUX_SYMBOL_STR(device_remove_file) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x12da5bb2, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0xdfd68f9a, __VMLINUX_SYMBOL_STR(usb_gstrings_attach) },
	{ 0x7e9efe8e, __VMLINUX_SYMBOL_STR(complete_and_exit) },
	{ 0x675ab7f5, __VMLINUX_SYMBOL_STR(up_read) },
	{ 0x2238416d, __VMLINUX_SYMBOL_STR(usb_free_all_descriptors) },
	{ 0x5fc56a46, __VMLINUX_SYMBOL_STR(_raw_spin_unlock) },
	{ 0x8b762020, __VMLINUX_SYMBOL_STR(dequeue_signal) },
	{ 0x349cba85, __VMLINUX_SYMBOL_STR(strchr) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x97255bdf, __VMLINUX_SYMBOL_STR(strlen) },
	{ 0x7ab88a45, __VMLINUX_SYMBOL_STR(system_freezing_cnt) },
	{ 0xf7802486, __VMLINUX_SYMBOL_STR(__aeabi_uidivmod) },
	{ 0x76cf47f6, __VMLINUX_SYMBOL_STR(__aeabi_llsl) },
	{ 0x2a3aa678, __VMLINUX_SYMBOL_STR(_test_and_clear_bit) },
	{ 0x975e426c, __VMLINUX_SYMBOL_STR(config_item_put) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0x71f59670, __VMLINUX_SYMBOL_STR(vfs_fsync) },
	{ 0x91715312, __VMLINUX_SYMBOL_STR(sprintf) },
	{ 0xfdc79d1c, __VMLINUX_SYMBOL_STR(usb_function_unregister) },
	{ 0xcd800e3e, __VMLINUX_SYMBOL_STR(kthread_create_on_node) },
	{ 0x4e8a8c01, __VMLINUX_SYMBOL_STR(down_read) },
	{ 0xe2d5255a, __VMLINUX_SYMBOL_STR(strcmp) },
	{ 0x275ef902, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0x1fab5905, __VMLINUX_SYMBOL_STR(wait_for_completion) },
	{ 0x70ec9f55, __VMLINUX_SYMBOL_STR(vfs_read) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0xcd63c845, __VMLINUX_SYMBOL_STR(__aeabi_lasr) },
	{ 0x39829799, __VMLINUX_SYMBOL_STR(device_register) },
	{ 0xa1e31a50, __VMLINUX_SYMBOL_STR(usb_put_function_instance) },
	{ 0x5a5a94a6, __VMLINUX_SYMBOL_STR(kstrtou8) },
	{ 0x5c4f1a32, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x51d559d1, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irqrestore) },
	{ 0xb3b74019, __VMLINUX_SYMBOL_STR(freezing_slow_path) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x877bf2cf, __VMLINUX_SYMBOL_STR(unregister_gadget_item) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x774a8d57, __VMLINUX_SYMBOL_STR(usb_ep_autoconfig) },
	{ 0x1a1431fd, __VMLINUX_SYMBOL_STR(_raw_spin_unlock_irq) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0x87d35cda, __VMLINUX_SYMBOL_STR(config_group_init_type_name) },
	{ 0x2f18d33c, __VMLINUX_SYMBOL_STR(up_write) },
	{ 0x95e13502, __VMLINUX_SYMBOL_STR(down_write) },
	{ 0x3a8fc241, __VMLINUX_SYMBOL_STR(fput) },
	{ 0x8ee3b82f, __VMLINUX_SYMBOL_STR(usb_function_register) },
	{ 0x2ec12dd4, __VMLINUX_SYMBOL_STR(usb_composite_setup_continue) },
	{ 0x36a8ebe2, __VMLINUX_SYMBOL_STR(device_create_file) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x3ef9d189, __VMLINUX_SYMBOL_STR(put_device) },
	{ 0x1000e51, __VMLINUX_SYMBOL_STR(schedule) },
	{ 0x3507a132, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irq) },
	{ 0x4482cdb, __VMLINUX_SYMBOL_STR(__refrigerator) },
	{ 0x8db7ecaa, __VMLINUX_SYMBOL_STR(config_ep_by_speed) },
	{ 0xbe541fc6, __VMLINUX_SYMBOL_STR(wake_up_process) },
	{ 0xcc5005fe, __VMLINUX_SYMBOL_STR(msleep_interruptible) },
	{ 0x9c0bd51f, __VMLINUX_SYMBOL_STR(_raw_spin_lock) },
	{ 0x598542b2, __VMLINUX_SYMBOL_STR(_raw_spin_lock_irqsave) },
	{ 0xd85cd67e, __VMLINUX_SYMBOL_STR(__wake_up) },
	{ 0x344b7739, __VMLINUX_SYMBOL_STR(prepare_to_wait_event) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x6df1aaf1, __VMLINUX_SYMBOL_STR(kernel_sigaction) },
	{ 0x23a0fb46, __VMLINUX_SYMBOL_STR(send_sig_info) },
	{ 0x9e61bb05, __VMLINUX_SYMBOL_STR(set_freezable) },
	{ 0xa5db3684, __VMLINUX_SYMBOL_STR(invalidate_mapping_pages) },
	{ 0x83aad604, __VMLINUX_SYMBOL_STR(usb_assign_descriptors) },
	{ 0x1cfb04fa, __VMLINUX_SYMBOL_STR(finish_wait) },
	{ 0x8b2f8473, __VMLINUX_SYMBOL_STR(usb_interface_id) },
	{ 0x907c7e44, __VMLINUX_SYMBOL_STR(dev_warn) },
	{ 0x33fb6b47, __VMLINUX_SYMBOL_STR(device_unregister) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0x676bbc0f, __VMLINUX_SYMBOL_STR(_set_bit) },
	{ 0xb81960ca, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0x99bb8806, __VMLINUX_SYMBOL_STR(memmove) },
	{ 0x16f1e2dc, __VMLINUX_SYMBOL_STR(dev_set_name) },
	{ 0x49ebacbd, __VMLINUX_SYMBOL_STR(_clear_bit) },
	{ 0x43d39986, __VMLINUX_SYMBOL_STR(__init_rwsem) },
	{ 0x8d995b7, __VMLINUX_SYMBOL_STR(vfs_write) },
	{ 0x5536d626, __VMLINUX_SYMBOL_STR(filp_open) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=libcomposite,configfs";


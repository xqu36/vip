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
	{ 0x77dbe8c4, __VMLINUX_SYMBOL_STR(bus_register) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0xf88c3301, __VMLINUX_SYMBOL_STR(sg_init_table) },
	{ 0xda21f824, __VMLINUX_SYMBOL_STR(driver_register) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x7ca585ae, __VMLINUX_SYMBOL_STR(arm_dma_ops) },
	{ 0xd8811dcf, __VMLINUX_SYMBOL_STR(virtio_check_driver_offered_feature) },
	{ 0x5113c4b9, __VMLINUX_SYMBOL_STR(virtqueue_kick_prepare) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0x62f348c1, __VMLINUX_SYMBOL_STR(virtqueue_kick) },
	{ 0x91715312, __VMLINUX_SYMBOL_STR(sprintf) },
	{ 0xb1d9e1d8, __VMLINUX_SYMBOL_STR(virtqueue_get_buf) },
	{ 0x275ef902, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0xff8cbb1f, __VMLINUX_SYMBOL_STR(idr_destroy) },
	{ 0x39829799, __VMLINUX_SYMBOL_STR(device_register) },
	{ 0x5c4f1a32, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0xd9d8dec2, __VMLINUX_SYMBOL_STR(device_find_child) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xedb69567, __VMLINUX_SYMBOL_STR(driver_unregister) },
	{ 0x328a05f1, __VMLINUX_SYMBOL_STR(strncpy) },
	{ 0x7baf4ecb, __VMLINUX_SYMBOL_STR(virtqueue_disable_cb) },
	{ 0x84b183ae, __VMLINUX_SYMBOL_STR(strncmp) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0xbfbcddf8, __VMLINUX_SYMBOL_STR(idr_alloc) },
	{ 0x40d7c29e, __VMLINUX_SYMBOL_STR(__virtqueue_add_sgs) },
	{ 0x8078fc99, __VMLINUX_SYMBOL_STR(bus_unregister) },
	{ 0x32907b91, __VMLINUX_SYMBOL_STR(idr_remove) },
	{ 0x5dd3f59e, __VMLINUX_SYMBOL_STR(virtqueue_notify) },
	{ 0x93a4d55f, __VMLINUX_SYMBOL_STR(virtqueue_get_vring_size) },
	{ 0x4059792f, __VMLINUX_SYMBOL_STR(print_hex_dump) },
	{ 0x7a0befb5, __VMLINUX_SYMBOL_STR(_dev_info) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0xb5684e29, __VMLINUX_SYMBOL_STR(idr_find_slowpath) },
	{ 0xcd282fdb, __VMLINUX_SYMBOL_STR(unregister_virtio_driver) },
	{ 0x3ef9d189, __VMLINUX_SYMBOL_STR(put_device) },
	{ 0x3bd1b1f6, __VMLINUX_SYMBOL_STR(msecs_to_jiffies) },
	{ 0xd62c833f, __VMLINUX_SYMBOL_STR(schedule_timeout) },
	{ 0xd85cd67e, __VMLINUX_SYMBOL_STR(__wake_up) },
	{ 0x344b7739, __VMLINUX_SYMBOL_STR(prepare_to_wait_event) },
	{ 0x309ed1c1, __VMLINUX_SYMBOL_STR(device_for_each_child) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x1cfb04fa, __VMLINUX_SYMBOL_STR(finish_wait) },
	{ 0x907c7e44, __VMLINUX_SYMBOL_STR(dev_warn) },
	{ 0x33fb6b47, __VMLINUX_SYMBOL_STR(device_unregister) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0x16f1e2dc, __VMLINUX_SYMBOL_STR(dev_set_name) },
	{ 0x528d0c14, __VMLINUX_SYMBOL_STR(idr_init) },
	{ 0xfb22094e, __VMLINUX_SYMBOL_STR(virtqueue_enable_cb) },
	{ 0x6c07d933, __VMLINUX_SYMBOL_STR(add_uevent_var) },
	{ 0x5e54af9c, __VMLINUX_SYMBOL_STR(register_virtio_driver) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=virtio,virtio_ring";

MODULE_ALIAS("virtio:d00000007v*");

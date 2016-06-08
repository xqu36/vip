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
	{ 0x2d3385d3, __VMLINUX_SYMBOL_STR(system_wq) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x12da5bb2, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0x48b7249b, __VMLINUX_SYMBOL_STR(vring_del_virtqueue) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x97255bdf, __VMLINUX_SYMBOL_STR(strlen) },
	{ 0x7ca585ae, __VMLINUX_SYMBOL_STR(arm_dma_ops) },
	{ 0xccd4c626, __VMLINUX_SYMBOL_STR(register_virtio_device) },
	{ 0xe2fae716, __VMLINUX_SYMBOL_STR(kmemdup) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0xcbee6439, __VMLINUX_SYMBOL_STR(ida_simple_get) },
	{ 0xe2d5255a, __VMLINUX_SYMBOL_STR(strcmp) },
	{ 0x81f3afb, __VMLINUX_SYMBOL_STR(complete_all) },
	{ 0x275ef902, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0x1fab5905, __VMLINUX_SYMBOL_STR(wait_for_completion) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0xff8cbb1f, __VMLINUX_SYMBOL_STR(idr_destroy) },
	{ 0xe3cfb3c8, __VMLINUX_SYMBOL_STR(device_del) },
	{ 0x5c4f1a32, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x32996351, __VMLINUX_SYMBOL_STR(mutex_lock_interruptible) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x71c90087, __VMLINUX_SYMBOL_STR(memcmp) },
	{ 0x29e1b020, __VMLINUX_SYMBOL_STR(ida_simple_remove) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0x6220b4a2, __VMLINUX_SYMBOL_STR(crc32_le) },
	{ 0xbfbcddf8, __VMLINUX_SYMBOL_STR(idr_alloc) },
	{ 0xd857f35c, __VMLINUX_SYMBOL_STR(device_add) },
	{ 0xcb0b902d, __VMLINUX_SYMBOL_STR(request_firmware_nowait) },
	{ 0x43e3990f, __VMLINUX_SYMBOL_STR(unregister_virtio_device) },
	{ 0x7f63b31e, __VMLINUX_SYMBOL_STR(_memcpy_toio) },
	{ 0x32907b91, __VMLINUX_SYMBOL_STR(idr_remove) },
	{ 0xb7f6357, __VMLINUX_SYMBOL_STR(module_put) },
	{ 0x1df6b330, __VMLINUX_SYMBOL_STR(vring_new_virtqueue) },
	{ 0x7a0befb5, __VMLINUX_SYMBOL_STR(_dev_info) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0xb5684e29, __VMLINUX_SYMBOL_STR(idr_find_slowpath) },
	{ 0x3ef9d189, __VMLINUX_SYMBOL_STR(put_device) },
	{ 0xff05fa13, __VMLINUX_SYMBOL_STR(vring_interrupt) },
	{ 0x705e4b6b, __VMLINUX_SYMBOL_STR(get_device) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x55cc1cf2, __VMLINUX_SYMBOL_STR(device_initialize) },
	{ 0xd12d393b, __VMLINUX_SYMBOL_STR(request_firmware) },
	{ 0x907c7e44, __VMLINUX_SYMBOL_STR(dev_warn) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0xb2d48a2e, __VMLINUX_SYMBOL_STR(queue_work_on) },
	{ 0xb95f98d6, __VMLINUX_SYMBOL_STR(_memset_io) },
	{ 0xb81960ca, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0x16f1e2dc, __VMLINUX_SYMBOL_STR(dev_set_name) },
	{ 0x528d0c14, __VMLINUX_SYMBOL_STR(idr_init) },
	{ 0xe84caf3, __VMLINUX_SYMBOL_STR(vring_transport_features) },
	{ 0x5807abb9, __VMLINUX_SYMBOL_STR(release_firmware) },
	{ 0xdbf291ed, __VMLINUX_SYMBOL_STR(try_module_get) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=virtio_ring,virtio";


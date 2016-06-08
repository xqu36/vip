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
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x49342e21, __VMLINUX_SYMBOL_STR(v4l2_event_unsubscribe) },
	{ 0x12da5bb2, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0xf9a482f9, __VMLINUX_SYMBOL_STR(msleep) },
	{ 0x5da1445c, __VMLINUX_SYMBOL_STR(video_device_release_empty) },
	{ 0x51eafc8e, __VMLINUX_SYMBOL_STR(param_ops_int) },
	{ 0x67c2fa54, __VMLINUX_SYMBOL_STR(__copy_to_user) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x8128254c, __VMLINUX_SYMBOL_STR(v4l2_device_unregister) },
	{ 0x819c40f7, __VMLINUX_SYMBOL_STR(v4l2_ctrl_handler_free) },
	{ 0x8fdbe2e1, __VMLINUX_SYMBOL_STR(v4l2_ctrl_g_ctrl) },
	{ 0xc87c1f84, __VMLINUX_SYMBOL_STR(ktime_get) },
	{ 0x768c213d, __VMLINUX_SYMBOL_STR(usb_kill_urb) },
	{ 0x74fa4aac, __VMLINUX_SYMBOL_STR(__video_register_device) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0x999e8297, __VMLINUX_SYMBOL_STR(vfree) },
	{ 0xb6b86987, __VMLINUX_SYMBOL_STR(v4l2_device_register) },
	{ 0x275ef902, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0xe707d823, __VMLINUX_SYMBOL_STR(__aeabi_uidiv) },
	{ 0xdd0a2ba2, __VMLINUX_SYMBOL_STR(strlcat) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0xd7869797, __VMLINUX_SYMBOL_STR(v4l2_device_disconnect) },
	{ 0x5f754e5a, __VMLINUX_SYMBOL_STR(memset) },
	{ 0x32996351, __VMLINUX_SYMBOL_STR(mutex_lock_interruptible) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xa123fcb6, __VMLINUX_SYMBOL_STR(video_unregister_device) },
	{ 0xb2ccc59f, __VMLINUX_SYMBOL_STR(usb_set_interface) },
	{ 0xbe134f1, __VMLINUX_SYMBOL_STR(v4l2_ctrl_subscribe_event) },
	{ 0x73e20c1c, __VMLINUX_SYMBOL_STR(strlcpy) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0xfbd7e4f8, __VMLINUX_SYMBOL_STR(v4l2_fh_release) },
	{ 0xc3ca6624, __VMLINUX_SYMBOL_STR(usb_free_coherent) },
	{ 0x2196324, __VMLINUX_SYMBOL_STR(__aeabi_idiv) },
	{ 0x51f8fc89, __VMLINUX_SYMBOL_STR(vm_insert_page) },
	{ 0x4857d239, __VMLINUX_SYMBOL_STR(__v4l2_ctrl_s_ctrl) },
	{ 0xb7f6357, __VMLINUX_SYMBOL_STR(module_put) },
	{ 0xcb717fef, __VMLINUX_SYMBOL_STR(usb_submit_urb) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x4d6cc955, __VMLINUX_SYMBOL_STR(video_devdata) },
	{ 0x3bd1b1f6, __VMLINUX_SYMBOL_STR(msecs_to_jiffies) },
	{ 0x70af1c48, __VMLINUX_SYMBOL_STR(input_register_device) },
	{ 0xd62c833f, __VMLINUX_SYMBOL_STR(schedule_timeout) },
	{ 0xacfb898b, __VMLINUX_SYMBOL_STR(v4l2_ctrl_handler_setup) },
	{ 0x20b0371b, __VMLINUX_SYMBOL_STR(usb_clear_halt) },
	{ 0xee4ba273, __VMLINUX_SYMBOL_STR(input_free_device) },
	{ 0xa0b04675, __VMLINUX_SYMBOL_STR(vmalloc_32) },
	{ 0x4c325560, __VMLINUX_SYMBOL_STR(v4l2_fh_open) },
	{ 0xd85cd67e, __VMLINUX_SYMBOL_STR(__wake_up) },
	{ 0x344b7739, __VMLINUX_SYMBOL_STR(prepare_to_wait_event) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x9d669763, __VMLINUX_SYMBOL_STR(memcpy) },
	{ 0x49e2e425, __VMLINUX_SYMBOL_STR(input_unregister_device) },
	{ 0x1cfb04fa, __VMLINUX_SYMBOL_STR(finish_wait) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0x676bbc0f, __VMLINUX_SYMBOL_STR(_set_bit) },
	{ 0x818ae7e, __VMLINUX_SYMBOL_STR(usb_ifnum_to_if) },
	{ 0xb81960ca, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0xa828cd55, __VMLINUX_SYMBOL_STR(vmalloc_to_page) },
	{ 0x818ca2e, __VMLINUX_SYMBOL_STR(usb_alloc_coherent) },
	{ 0x7a872ecc, __VMLINUX_SYMBOL_STR(v4l2_device_put) },
	{ 0xb83435d7, __VMLINUX_SYMBOL_STR(usb_free_urb) },
	{ 0xd86aa892, __VMLINUX_SYMBOL_STR(video_ioctl2) },
	{ 0xacb57ed3, __VMLINUX_SYMBOL_STR(v4l2_ctrl_poll) },
	{ 0xdbf291ed, __VMLINUX_SYMBOL_STR(try_module_get) },
	{ 0xff096f19, __VMLINUX_SYMBOL_STR(usb_alloc_urb) },
	{ 0x4cdb3178, __VMLINUX_SYMBOL_STR(ns_to_timeval) },
	{ 0xf20a5030, __VMLINUX_SYMBOL_STR(input_allocate_device) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "B5010A6EE5263052D5B92C3");

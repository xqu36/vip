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
	{ 0x68abb700, __VMLINUX_SYMBOL_STR(kobject_put) },
	{ 0x31e791fd, __VMLINUX_SYMBOL_STR(kmem_cache_destroy) },
	{ 0xe260d1d0, __VMLINUX_SYMBOL_STR(simple_pin_fs) },
	{ 0xee57ea5d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x12da5bb2, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0x9b388444, __VMLINUX_SYMBOL_STR(get_zeroed_page) },
	{ 0xfbc74f64, __VMLINUX_SYMBOL_STR(__copy_from_user) },
	{ 0x675ab7f5, __VMLINUX_SYMBOL_STR(up_read) },
	{ 0x528c709d, __VMLINUX_SYMBOL_STR(simple_read_from_buffer) },
	{ 0x5fc56a46, __VMLINUX_SYMBOL_STR(_raw_spin_unlock) },
	{ 0x66a8b75a, __VMLINUX_SYMBOL_STR(generic_file_llseek) },
	{ 0x188a3dfb, __VMLINUX_SYMBOL_STR(timespec_trunc) },
	{ 0x2e5810c6, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr1) },
	{ 0x97255bdf, __VMLINUX_SYMBOL_STR(strlen) },
	{ 0xb473da40, __VMLINUX_SYMBOL_STR(simple_write_end) },
	{ 0x5f5df727, __VMLINUX_SYMBOL_STR(simple_release_fs) },
	{ 0x34184afe, __VMLINUX_SYMBOL_STR(current_kernel_time) },
	{ 0x276dd2a9, __VMLINUX_SYMBOL_STR(generic_delete_inode) },
	{ 0xcdc49e19, __VMLINUX_SYMBOL_STR(lockref_get) },
	{ 0xa66244d2, __VMLINUX_SYMBOL_STR(dput) },
	{ 0x69353471, __VMLINUX_SYMBOL_STR(inc_nlink) },
	{ 0x7771d9ae, __VMLINUX_SYMBOL_STR(mutex_unlock) },
	{ 0xe584db4e, __VMLINUX_SYMBOL_STR(mount_single) },
	{ 0xd967e85e, __VMLINUX_SYMBOL_STR(generic_read_dir) },
	{ 0xe2d5255a, __VMLINUX_SYMBOL_STR(strcmp) },
	{ 0x4e8a8c01, __VMLINUX_SYMBOL_STR(down_read) },
	{ 0x44b5a2c1, __VMLINUX_SYMBOL_STR(kobject_create_and_add) },
	{ 0xc605ec3e, __VMLINUX_SYMBOL_STR(d_delete) },
	{ 0xfa2a45e, __VMLINUX_SYMBOL_STR(__memzero) },
	{ 0xfd7b6ad9, __VMLINUX_SYMBOL_STR(kern_path) },
	{ 0xa5050e45, __VMLINUX_SYMBOL_STR(kill_litter_super) },
	{ 0xadedf06c, __VMLINUX_SYMBOL_STR(simple_write_begin) },
	{ 0x4627fb43, __VMLINUX_SYMBOL_STR(__mutex_init) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xe3e3262b, __VMLINUX_SYMBOL_STR(d_rehash) },
	{ 0x328a05f1, __VMLINUX_SYMBOL_STR(strncpy) },
	{ 0xa5df38a7, __VMLINUX_SYMBOL_STR(kmem_cache_free) },
	{ 0xa8cf2f1, __VMLINUX_SYMBOL_STR(mutex_lock) },
	{ 0x62825cb0, __VMLINUX_SYMBOL_STR(simple_readpage) },
	{ 0x69c53bc2, __VMLINUX_SYMBOL_STR(nd_set_link) },
	{ 0xb7f6357, __VMLINUX_SYMBOL_STR(module_put) },
	{ 0xc6cbbc89, __VMLINUX_SYMBOL_STR(capable) },
	{ 0x17506ac5, __VMLINUX_SYMBOL_STR(kmem_cache_alloc) },
	{ 0x83f1a64f, __VMLINUX_SYMBOL_STR(simple_unlink) },
	{ 0xb51f6f70, __VMLINUX_SYMBOL_STR(simple_setattr) },
	{ 0x93fca811, __VMLINUX_SYMBOL_STR(__get_free_pages) },
	{ 0x8b8059bd, __VMLINUX_SYMBOL_STR(in_group_p) },
	{ 0x3c3011e6, __VMLINUX_SYMBOL_STR(d_drop) },
	{ 0x9b6b855b, __VMLINUX_SYMBOL_STR(path_put) },
	{ 0x9c0bd51f, __VMLINUX_SYMBOL_STR(_raw_spin_lock) },
	{ 0xf68ea58b, __VMLINUX_SYMBOL_STR(kmem_cache_create) },
	{ 0xdef991e0, __VMLINUX_SYMBOL_STR(register_filesystem) },
	{ 0x7afa89fc, __VMLINUX_SYMBOL_STR(vsnprintf) },
	{ 0x4302d0eb, __VMLINUX_SYMBOL_STR(free_pages) },
	{ 0xe953b21f, __VMLINUX_SYMBOL_STR(get_next_ino) },
	{ 0x71e55c67, __VMLINUX_SYMBOL_STR(kernel_kobj) },
	{ 0xfff8ea, __VMLINUX_SYMBOL_STR(iput) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x4c606d69, __VMLINUX_SYMBOL_STR(iunique) },
	{ 0x5de0893, __VMLINUX_SYMBOL_STR(always_delete_dentry) },
	{ 0xa7bd85b4, __VMLINUX_SYMBOL_STR(generic_readlink) },
	{ 0x4f7a593b, __VMLINUX_SYMBOL_STR(d_make_root) },
	{ 0xf2b04619, __VMLINUX_SYMBOL_STR(simple_statfs) },
	{ 0xa6b927b6, __VMLINUX_SYMBOL_STR(d_alloc_name) },
	{ 0xa554fd90, __VMLINUX_SYMBOL_STR(unregister_filesystem) },
	{ 0xefd6cf06, __VMLINUX_SYMBOL_STR(__aeabi_unwind_cpp_pr0) },
	{ 0xb81960ca, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0x5b67a94a, __VMLINUX_SYMBOL_STR(new_inode) },
	{ 0xef9a781d, __VMLINUX_SYMBOL_STR(d_instantiate) },
	{ 0xdbf291ed, __VMLINUX_SYMBOL_STR(try_module_get) },
	{ 0x29b13f80, __VMLINUX_SYMBOL_STR(simple_rmdir) },
	{ 0x7f340669, __VMLINUX_SYMBOL_STR(__d_drop) },
	{ 0xe914e41e, __VMLINUX_SYMBOL_STR(strcpy) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "2F4F2BCFD0EC09AC149A480");

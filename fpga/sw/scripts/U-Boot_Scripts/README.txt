To execute scripts on the U-Boot platform, scripts must be formatted into U-Boot images.
Execute the following command to convert the UpdateScript into UpdateScript.img:

	mkimage -T script -C none -n 'Firmware Update Script' -d UpdateScript UpdateScript.img

For more information and examples, see the following website:

	http://www.denx.de/wiki/view/DULG/UBootScripts

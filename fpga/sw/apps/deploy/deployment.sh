#!/bin/bash

###############################################################
#	This doucment is to be run right before deployment    #
#	it removes unnecessary files and changes the password #
#	after running, it deletes its self		      #
###############################################################

echo 'checking package list...'
python /mnt/ramdisk/apps/deploy/compair.py
echo "package list OK"

#Ask the user for an ID
echo "what is this device's ID?";
read uniqueid;
echo ''$uniqueid'' >  /etc/uniqsysidentity.conf

#Ask for the device's password
echo "enter new device password";
read passs;
echo 'ubuntu:'$passs'' | sudo chpasswd

#change password
#echo "ubuntu:@G30rg1@T3chN0tUG@1738" | sudo chpasswd

#cron job stuff
sudo rm -r /etc/cron.d/
echo "* * * * * ubuntu cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/cronScripts/sentinel_scrpt.sh" > /etc/cron.d/sentinel
echo "* * * * * ubuntu cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/cronScripts/sentinel2.sh" >> etc/cron.d/healthMon
echo "@reboot ubuntu cd /mnt/ramdisk/appls/ev; /bin/bash /mnt/ramdisk/apps/cronScripts/devPacket.sh" >> /etc/cron.d/devPacket
echo "30 5 * * * ubuntu cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/ev/health_update.sh" >> /etc/cron.d/healthUpdate
echo "30 4 * * * root cd ${SOFTWARE}; /bin/bash ${SOFTWARE}/getSoftwareUpdate.sh" >> /etc/cron.d/softwareUpdate
echo "30 4 * * * root cd ${SOFTWARE}; /bin/bash ${SOFTWARE}/updateChecker.sh" >> /etc/cron.d/firmwareUpdate

#fstab reset
sudo rm /etc/fstab
sudo echo "tmpfs	/mnt/ramdisk tmpfs rw,suid,dev,exec,auto,nouser,async,size=64M	0 0" > /etc/fstab

#removing packages
echo "Y" | sudo apt-get purge bsdmainutils
echo "Y" | sudo apt-get purge build-essential
echo "Y" | sudo apt-get purge busybox
echo "Y" | sudo apt-get purge busybox-static
echo "Y" | sudo apt-get purge bzip2
echo "Y" | sudo apt-get purge console-setup
echo "Y" | sudo apt-get purge cpp
echo "Y" | sudo apt-get purge cpp-4.8
echo "Y" | sudo apt-get purge dh-apparmor
echo "Y" | sudo apt-get purge dmsetup
echo "Y" | sudo apt-get purge fakeroot
echo "Y" | sudo apt-get purge gettext
echo "Y" | sudo apt-get purge gettext-base
echo "Y" | sudo apt-get purge gir1.2-atk-1.0
echo "Y" | sudo apt-get purge gir1.2-freedes
echo "Y" | sudo apt-get purge gir1.2-gdkpixb
echo "Y" | sudo apt-get purge gir1.2-glib-2.0
echo "Y" | sudo apt-get purge groff-base
echo "Y" | sudo apt-get purge hicolor-icon-theme
echo "Y" | sudo apt-get purge keyboard-configuration
echo "Y" | sudo apt-get purge krb5-locales
echo "Y" | sudo apt-get purge less
echo "Y" | sudo apt-get purge locales
echo "Y" | sudo apt-get purge linux-libc-dev
echo "Y" | sudo apt-get purge lockfile-progs
echo "Y" | sudo apt-get purge logrotate
echo "Y" | sudo apt-get purge lsb-release
echo "Y" | sudo apt-get purge make
echo "Y" | sudo apt-get purge manpages
echo "Y" | sudo apt-get purge mawk
echo "Y" | sudo apt-get purge patch
echo "Y" | sudo apt-get purge pkg-config
echo "Y" | sudo apt-get purge sgml-base
echo "Y" | sudo apt-get purge vim-common
echo "Y" | sudo apt-get purge x11proto-composite-dev
echo "Y" | sudo apt-get purge x11proto-kb-dev
echo "Y" | sudo apt-get purge x11proto-randr-dev
echo "Y" | sudo apt-get purge x11proto-xinerama-dev
echo "Y" | sudo apt-get purge xauth
echo "Y" | sudo apt-get purge xkb-data
echo "Y" | sudo apt-get purge xorg-sgml-doctools
echo "Y" | sudo apt-get purge xtrans-dev
echo "Y" | sudo apt-get purge xz-utils
echo "Y" | sudo apt-get purge whiptail
echo "Y" | sudo apt-get purge apt

#remove unnecessary folders and make an empty ev folder for logs
sudo rm -r /home/ubuntu/
sudo mkdir /home/ubuntu/ev

#delete wifi settings
sudo rm /etc/udev/rules.d/70-persistent-net.rules

#delete its self to cover up changed password
sudo rm -- "$0"
exit 0
#!/bin/bash

###############################################################
#	This doucment is to be run right before deployment    #
#	it removes unnecessary files and changes the password #
#	after running, it deletes its self		      #
###############################################################

#This will ask the user for the version number and write it to a .txt file
echo "what version is this?";
read  version;
echo 'version number: '$version'' > /home/ubuntu/version

#change password
echo "ubuntu:@G30rg1@T3chN0tUG@1738" | sudo chpasswd

#cron job stuff
sudo cp /home/ubuntu/cronScripts/updateSoftware.sh /etc/cron.weekly/
sudo cp /home/ubuntu/cronScripts/updateChecker.sh /etc/cron.monthly/
sudo cp /home/ubuntu/cronScripts/updateSoftware /etc/cron.weekly/
sudo cp /home/ubuntu/cronScripts/updateChecker /etc/cron.monthly/
(crontab -l 2>/dev/null; echo "* * * * * cd /home/ubuntu; /bin/bash /home/ubuntu/sentinel2.sh_script.sh") | crontab -
(sudo crontab -l 2>/dev/null; echo "0 4   *   *   *    /sbin/shutdown -r now") | sudo crontab -

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
echo "Y" | sudo apt-get purge init-system-helpers
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
echo "Y" | sudo apt-get purge x11-common
echo "Y" | sudo apt-get purge x11proto-composite-dev
echo "Y" | sudo apt-get purge x11proto-core
echo "Y" | sudo apt-get purge x11proto-kb-dev
echo "Y" | sudo apt-get purge x11proto-randr-dev
echo "Y" | sudo apt-get purge x11proto-xinerama-dev
echo "Y" | sudo apt-get purge xauth
echo "Y" | sudo apt-get purge xkb-data
echo "Y" | sudo apt-get purge xorg-sgml-doctools
echo "Y" | sudo apt-get purge xtrans-dev
echo "Y" | sudo apt-get purge xz-utils
echo "Y" | sudo apt-get purge whiptail
echo "Y" | sudo apt-get purge wget
echo "Y" | sudo apt-get purge net-tools
echo "Y" | sudo apt-get purge netcat-openbsd

#delete its self to cover up changed password
sudo rm -- "$0"

#!/bin/bash
#deployment2

###############################################################
#	This doucment is to be run right before deployment    #
#	it removes unnecessary files and changes the password #
#	after running, it deletes its self		      #
###############################################################

#Make the script to delete items with python
python /lib/deploy/compair.py

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
(crontab -l 2>/dev/null; echo "* * * * * cd /mnt/ramdisk/apps/cronScripts; /bin/bash /mnt/ramdisk/apps/cronScripts/sentinel2.sh_script.sh") | crontab -
(sudo crontab -l 2>/dev/null; echo "0 4   *   *   *    /sbin/shutdown -r now") | sudo crontab -

#removing packages
sudo chmod +x /lib/deploy/blacklist.sh
source /lib/deploy/blacklist.sh

#delete its self to cover up changed password
sudo rm -- "$0"n
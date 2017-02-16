#!/bin/bash
# PATCH: applies cron changes every time getSoftwareUpdate.sh runs.

echo "30 5 * * * ubuntu cd /mnt/ramdisk/apps/ev; /usr/bin/python /mnt/ramdisk/apps/ev/health_update.py" > /etc/cron.d/healthUpdate
echo "@reboot ubuntu sleep 60 &&  cd /mnt/ramdisk/apps/ev; /bin/bash /mnt/ramdisk/apps/cronScripts/devPacket.sh" > /etc/cron.d/devPacket

#!/bin/bash

# Michael Capone, 6/10/2016

# Bash script that will handle retrieving the user defined software.
# In short, the program reaches out to the specified website and 
# downloads the newest certificate. This script should be
# run as a cronjob that operates DAILY.

# PATCH TIME! (2/16/17)
# sources a file that updates the system's cron, then deletes that file
source /mnt/ramdisk/apps/cronScripts/cronSetup.sh

# Web URL of the binary file (dummy file for now)
WEB_URL="http://techcities.vip.gatech.edu/files/"
SOFTWARE="new_softwareupdate.secure"
SIGNATURE="new_softwareupdate.sha256"
SOFTWARE_URL="${WEB_URL}${SOFTWARE}"
SIGNATURE_URL="${WEB_URL}${SIGNATURE}"
RSA_KEY="rsa.pub"
LOGS="/home/ubuntu/ev/sensor.log"

# Location of the target directory
MOUNTED_DIRECTORY="/etc/software_updates/"
# Name for downloaded file

echo_and_log() {
  echo -e "$1"
  echo -e "${1} | $(date +\"%c\")" >> "$LOGS"
}

# Check that the path in MOUNTED_DIRECTORY exists
if [ -d "$MOUNTED_DIRECTORY" ]; then
    # First test to see if the connection is available
    if wget --spider --ignore-case "$WEB_URL"; then
        # Download the files to MOUNTED_DIRECTORY if newer
        if wget --ignore-case \
                --quota=30m \
                --directory-prefix "$MOUNTED_DIRECTORY" \
                --tries=10 \
                --accept secure \
                --timestamping \
                "$SOFTWARE_URL"; then
            echo_and_log "STATUS: New software update downloaded successfully!"
        else
            echo_and_log "ERROR: Unable to download new software update"
            exit 1
        fi
        if wget --ignore-case \
                --quota=30m \
                --directory-prefix "$MOUNTED_DIRECTORY" \
                --tries=10 \
                --accept sha256 \
                --timestamping \
                "$SIGNATURE_URL"; then
            echo_and_log "STATUS: Accompanying signature downloaded successfully!"
        else
            echo_and_log "ERROR: Unable to download accompanying signature"
            rm -f "$SOFTWARE"
            exit 1
        fi
        # Check the signature to see if they are valid updates
        openssl dgst -sha256 -verify "$RSA_KEY" -signature "$SIGNATURE" "$SOFTWARE"
        if [ $? -eq 1 ]
        then
          echo_and_log "ERROR: Not a valid software update! Removing files..."
          rm -f "$SOFTWARE" "$SIGNATURE"
        fi
    else
        echo_and_log "ERROR: Unable to reach specified URL!"
        exit 1
    fi
else
    echo_and_log "ERROR: Mounted directory not found."
    exit 1
fi

#!/bin/bash -x

# Michael Capone, 3/16/2016

# Basic bash script that will handle the OS portion of the firmware upgrade process.
# In short, the program reaches out to the specified website and downloads the
# boot.bin file. Once downloaded, it places the file into the designated partition
# where the file will be transferred by U-Boot to the QSPI. This script should be
# run as a cronjob that operates daily.

# Web URL of the binary file (dummy file for now)
WEB_URL="http://techcities.vip.gatech.edu/files/BOOT.bin"
# Location of the target directory
MOUNTED_DIRECTORY="/lib/firmware/"
# Name for downloaded file
OUTPUT_FILENAME="BOOT.bin"

# Check that the path in MOUNTED_DIRECTORY exists
if [ -d "$MOUNTED_DIRECTORY" ]; then
    # First test to see if the connection is available
    if wget --spider --ignore-case "$WEB_URL"; then
        # Download the file to MOUNTED_DIRECTORY if newer
        if wget --ignore-case \
                --quota=30m \
                --directory-prefix "$MOUNTED_DIRECTORY" \
                --tries=10 \
                --accept bin \
                --timestamping \
                "$WEB_URL"; then
            echo "STATUS: Update downloaded successfully!"
            reboot
        else
            echo "ERROR: Unable to execute wget script."
            exit 1
        fi
    else
        echo "ERROR: Unable to reach specified URL!"
        exit 1
    fi
else
    echo "ERROR: Mounted directory not found."
    exit 1
fi

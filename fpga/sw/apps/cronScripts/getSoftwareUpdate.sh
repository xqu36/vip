#!/bin/bash

# Michael Capone, 6/10/2016

# Bash script that will handle retrieving the user defined software.
# In short, the program reaches out to the specified website and 
# downloads the newest certificate. This script should be
# run as a cronjob that operates DAILY.

# Web URL of the binary file (dummy file for now)
WEB_URL="http://smartcities.gatech.edu/files/"
SOFTWARE="${WEB_URL}new_softwareupdate.secure"
SIGNATURE="${WEB_URL}new_softwareupdate.sha256"

# Location of the target directory
MOUNTED_DIRECTORY="/etc/software_updates/"
# Name for downloaded file

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
                "$SOFTWARE"; then
            echo "STATUS: New software update downloaded successfully!"
        else
            echo "ERROR: Unable to download new software update"
            exit 1
        fi
        if wget --ignore-case \
                --quota=30m \
                --directory-prefix "$MOUNTED_DIRECTORY" \
                --tries=10 \
                --accept sha256 \
                --timestamping \
                "$SIGNATURE"; then
            echo "STATUS: New software update downloaded successfully!"
        else
            echo "ERROR: Unable to download new software update"
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

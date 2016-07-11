#!/bin/bash -x

# Michael Capone, 6/10/2016

# Basic bash script that will handle the updating the node certificate.
# In short, the program reaches out to the specified website and 
# downloads the newest certificate. This script should be
# run as a cronjob that operates WEEKLY.

# Web URL of the binary file (dummy file for now)
WEB_URL="http://smartcities.gatech.edu/files/cacert.pem"
# Location of the target directory
MOUNTED_DIRECTORY="/home/ubuntu/ev/node1/cacert.pem"
# Name for downloaded file
OUTPUT_FILENAME="cacert.pem"

# Check that the path in MOUNTED_DIRECTORY exists
if [ -d "$MOUNTED_DIRECTORY" ]; then
    # First test to see if the connection is available
    if wget --spider --ignore-case "$WEB_URL"; then
        # Download the file to MOUNTED_DIRECTORY if newer
        if wget --ignore-case \
                --quota=30m \
                --directory-prefix "$MOUNTED_DIRECTORY" \
                --tries=10 \
                --accept pem \
                --timestamping \
                "$WEB_URL"; then
            echo "STATUS: New certificate downloaded successfully!"
        else
            echo "ERROR: Unable to download new certificate"
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

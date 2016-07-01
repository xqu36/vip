#! /bin/bash
### BEGIN INIT INFO
# Provides:          softwaresetup
# Required-Start:    $remote_fs $syslog     
# Required-Stop:
# Default-Start:     2
# Default-Stop:      
# X-Start-Before:    cron
# Short-Description: Sets up the file system for use of VIP files
# Description:
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/lsb/init-functions

CURRENT_SOFTWARE_ENC="/etc/software_updates/software_enc"
CURRENT_SOFTWARE="/etc/software_updates/software.tar.gz"
NEW_SOFTWARE_ENC="/etc/software_updates/new_softwareupdate_enc"
NEW_SOFTWARE="/etc/software_updates/new_softwareupdate.tar.gz"
CURRENT_OUTPUT="/mnt/ramdisk/software.tar.gz"
NEW_OUTPUT="/mnt/ramdisk/new_softwareupdate.tar.gz"
OUTPUT_DIRECTORY="/mnt/ramdisk"
VERSION="version.txt"
NEW_VERSION+="new_${VERSION}"
VERSION_TEXT=
NEW_VERSION_TEXT=
KEY=
LOGIN="ubuntu"

vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

change_owner () {
  chown -R "$LOGIN":"$LOGIN" /mnt
  echo "Successfully loaded current version of software"
}

setup () {
# Check that the file exists
if [ -e "$CURRENT_SOFTWARE_ENC" ]; then
  # Get the key from the specified BRAM on board
  #KEY=$(GET_AES_KEY -g 0x400000 -i 2>&1)
  KEY="00000000000000000000000000000000"
  # Decrypt the software updates
  openssl enc -aes-256-cbc -d -iv $KEY -K "$KEY" -in "$CURRENT_SOFTWARE_ENC" -out "$CURRENT_OUTPUT"
  if [ -e "$NEW_SOFTWARE_ENC" ]; then
    # Decrypdt the software updates
    openssl enc -aes-256-cbc -d -iv "$KEY" -K "$KEY" -in "$NEW_SOFTWARE_ENC" -out "$NEW_OUTPUT"
    # Compare the two versions
    tar --extract --file="$NEW_OUTPUT" "$VERSION"
    mv "$VERSION" "$NEW_VERSION"
    tar --extract --file="$CURRENT_OUTPUT" "$VERSION"
    VERSION_TEXT=$(cat $VERSION)
    NEW_VERSION_TEXT=$(cat $NEW_VERSION)
    if [ ! -z "$VERSION_TEXT" ]; then
      if [ ! -z "$NEW_VERSION_TEXT" ]; then
        vercomp "$VERSION_TEXT" "$NEW_VERSION_TEXT"
        case $? in
          0|1)
            rm -f "$NEW_OUTPUT"
            rm -f "$NEW_SOFTWARE_ENC"
            tar -xzvf "$CURRENT_OUTPUT" --directory "$OUTPUT_DIRECTORY"
            change_owner
            ;; 
          2)
            rm -f "$CURRENT_OUTPUT"
            rm -f "$CURRENT_SOFTWARE_ENC"
            mv "$NEW_SOFTWARE_ENC" "$CURRENT_SOFTWARE_ENC"
            tar -xzvf "$NEW_OUTPUT" --directory "$OUTPUT_DIRECTORY"
            change_owner
            ;;
          *)
            echo "ERROR: Great Scott!?!"
            return 1
            ;;
        esac
      else
        "ERROR: No version information in the new software file!"
        rm -f "$NEW_OUTPUT"
        rm -f "$NEW_SOFTWARE_ENC"
        tar -xzvf "$CURRENT_OUTPUT" --directory "$OUTPUT_DIRECTORY"
        change_owner
      fi
    else
      echo "ERROR: File does not contain version information"
      return 1
    fi
  else
    tar -xzvf "$CURRENT_SOFTWARE" --directory "$OUTPUT_DIRECTORY"
    change_owner
  fi
  
else
  echo "ERROR: $CURRENT_SOFTWARE not found."
  return 1
fi

#rm -f "$VERSION"
#rm -f "$NEW_VERSION"
return 0
}


case "$1" in
  start)
    log_action_msg "softwaresetup is running!"
    setup
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    # No-op
    ;;
  *)
    echo "Usage: $0 start" >&2
    exit 3
  ;;
esac

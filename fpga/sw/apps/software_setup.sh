#!/bin/bash -x

# Michael Capone, 6/28/2016
# BASH script that runs on STARTUP. On startup, it pulls the software
# decryption key to decrypt the user defined software. Once decrypted,
# the files are unpackaged and placed onto the RAM disk to prevent
# potential theft of IP.

CURRENT_SOFTWARE_ENC="/etc/software_updates/software_enc"
CURRENT_SOFTWARE="/etc/software_updates/software.tar.gz"
NEW_SOFTWARE_ENC="/etc/software_updates/new_softwareupdate_enc"
NEW_SOFTWARE="/etc/software_updates/new_softwareupdate.tar.gz"
CURRENT_OUTPUT="/mnt/ramdisk/software.tar.gz"
NEW_OUTPUT="/mnt/ramdisk/new_softwareupdate.tar.gz"
VERSION="version.txt"
NEW_VERSION+="new_${VERSION}"
VERSION_TEXT=
NEW_VERSION_TEXT=
KEY=

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
          0)
            rm -f "$NEW_OUTPUT"
            rm -f "$NEW_SOFTWARE_ENC"
            tar -xzvf "$CURRENT_OUTPUT"
            echo "Successfully loaded current version of software"
            ;; 
          1)
            rm -f "$NEW_OUTPUT"
            rm -f "$NEW_SOFTWARE_ENC"
            tar -xzvf "$CURRENT_OUTPUT"
            echo "Successfully loaded current version of software"
            ;;
          2)
            rm -f "$CURRENT_OUTPUT"
            rm -f "$CURRENT_SOFTWARE_ENC"
            mv "$NEW_SOFTWARE_ENC" "$CURRENT_SOFTWARE_ENC"
            tar -xzvf "$NEW_OUTPUT"
            echo "Successfully loaded current version of software"
            ;;
          *)
            echo "What on earth...?"
            exit 1
            ;;
        esac
      else
        "ERROR: No version information in the new software file!"
        rm -f "$NEW_OUTPUT"
        rm -f "$NEW_SOFTWARE_ENC"
        tar -xzvf "$CURRENT_OUTPUT"
        echo "Successfully loaded current version of software"
      fi
    else
      echo "ERROR: File does not contain version information"
      exit 1
    fi
  else
    tar -xzvf "$CURRENT_SOFTWARE"
  fi
  
else
  echo "ERROR: $CURRENT_SOFTWARE not found."
  exit 1
fi

rm -f "$VERSION"
rm -f "$NEW_VERSION"

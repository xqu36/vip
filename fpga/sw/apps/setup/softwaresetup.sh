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

CURRENT_SOFTWARE_ENC="/etc/software_updates/software.secure"
NEW_SOFTWARE_ENC="/etc/software_updates/new_softwareupdate.secure"
CURRENT_OUTPUT="/mnt/ramdisk/software.tar.gz"
NEW_OUTPUT="/mnt/ramdisk/new_softwareupdate.tar.gz"
OUTPUT_DIRECTORY="/mnt/ramdisk"
VERSION="version.txt"
NEW_VERSION+="new_${VERSION}"
VERSION_TEXT=
NEW_VERSION_TEXT=
KEY=""
RSA_FILE="${OUTPUT_DIRECTORY}/rsa.pub"
CURRENT_SOFTWARE_SIGNATURE="/etc/software_updates/software.sha256"
NEW_SOFTWARE_SIGNATURE="/etc/software_updates/new_softwareupdate.sha256"
AES_START=1073741824 
AES_END=1073741852
RSA_START=1073741856 
#RSA_END=1073742752
RSA_END=1073742248
LOGIN="ubuntu"

valid_version() {
    echo $1 | egrep -q '[0-9]+\.[0-9]+\.[0-9]+'
    if [[ $? != 0 ]]
    then
      return 1
    else
      return 0
    fi
}

vercomp () {
    # Sanitize the inputs 
    RC=0
    valid_version $1
    if [[ $? != 0 ]]
    then
      RC=1
      $1="0.0.0"
    fi

    valid_version $2
    if [[ $? != 0 ]]
    then
      RC=$(($RC + 1))
      $2="0.0.0"
    fi

    if [ $RC -e 2 ]
    then
      return 3
    fi

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
  #echo "Successfully loaded current version of software"
}

decrypt () {
    openssl enc -aes-256-cbc -d -salt -in "$1" -out "$2" -pass pass:${3}
}

check_signature() {
    # Check software signature
    extract_key $RSA_START $RSA_END
    echo -e "-----BEGIN PUBLIC KEY-----" > "$RSA_FILE"
    # Method to handle formatting
    printf '%s\n' "${KEY}" | sed -e "s/.\{64\}/&\n/g" >> "$RSA_FILE"
    echo "-----END PUBLIC KEY-----" >> "$RSA_FILE" 
    # Return of 0 means successful verification. Return of 1 indicates not valid
    openssl dgst -sha256  -verify "$RSA_FILE" -signature "$2" "$1"
    return $?
}

extract_key () {
  KEY=""
  START=$1
  END=$2
  HEX_INDEX=
  HEX_WORD=""
  HEX_CHARACTER=""

  for (( i=$START; i<=${END}; i=${i}+4)) 
  do
    printf -v HEX_INDEX '%x\n' "$i"
    HEX_WORD="$(/etc/init.d/peek 0x${HEX_INDEX})"
    for j in {2..8..2}
    do
      HEX_CHARACTER=${HEX_WORD:((10 - $j)):2}
      KEY="${KEY}$(echo -e \\x${HEX_CHARACTER})"
    done
    echo "${i}: ${HEX_WORD}" >> word_output.txt
    #echo "$KEY" >> key_output.txt
  done
  #KEY=${KEY//$'\r'/}
  echo "$KEY"
  #printf '%s\n' "${KEY}" # | sed -e "s/.\{64\}/&\n/g")
  return 0
}

setup () {
RC=0
# Checking to see that the current software is in the expected location
# If it is, verify the signature.
if [ -e "$CURRENT_SOFTWARE_ENC" ] && [ -e "$CURRENT_SOFTWARE_SIGNATURE" ]; then
  check_signature "$CURRENT_SOFTWARE_ENC" "$CURRENT_SOFTWARE_SIGNATURE"
  if [[ $? != 0 ]]; then
    echo -e "ERROR: Mismatch between current software and its signature!"
    #rm -f $CURRENT_SOFTWARE_ENC $CURRENT_SOFTWARE_SIGNATURE
    RC=$(($RC + 1))
  fi  
else
  echo -e "ERROR: Current software and corresponding signature not found!" 
  RC=$(($RC + 1))
fi

# Checking to see if there is new software in the expected location
# If it is, verify the signature.
if [ -e "$NEW_SOFTWARE_ENC" ] && [ -e "$NEW_SOFTWARE_SIGNATURE" ]; then
  check_signature "$NEW_SOFTWARE_ENC" "$NEW_SOFTWARE_SIGNATURE"
  if [[ $? != 0 ]]; then
    echo -e "ERROR: Mismatch between current software and its signature!"
    #rm -f $NEW_SOFTWARE_ENC $NEW_SOFTWARE_SIGNATURE
    RC=$(($RC + 2))
  fi  
else
  echo -e "No new software updates found!" 
  RC=$(($RC + 2))
fi

if [ "$RC" -ge 3 ]; then
  return 1
fi 
# Get the key from the specified BRAM on board
extract_key $AES_START $AES_END 
echo $RC
case $RC in
  0)
    # Decrypt the current software
    decrypt "$CURRENT_SOFTWARE_ENC" "$CURRENT_OUTPUT" "$KEY"
    # Decrypt the software update
    decrypt "$NEW_SOFTWARE_ENC" "$NEW_OUTPUT" "$KEY"
    # Compare the two versions to see which is newer
    tar --extract --file="$NEW_OUTPUT" "$VERSION" &> /dev/null
    mv "$VERSION" "$NEW_VERSION"
    tar --extract --file="$CURRENT_OUTPUT" "$VERSION" &> /dev/null
    VERSION_TEXT=$(cat $VERSION)
    NEW_VERSION_TEXT=$(cat $NEW_VERSION)
    vercomp "$VERSION_TEXT" "$NEW_VERSION_TEXT"
    case $? in
      0|1)
        rm -f "$NEW_OUTPUT"
        rm -f "$NEW_SOFTWARE_ENC"
        echo -e "Success! Loading software version number $VERSION_TEXT ..."
        tar -xzvf "$CURRENT_OUTPUT" --directory "$OUTPUT_DIRECTORY" &> /dev/null
        change_owner
        ;; 
      2)
        rm -f "$CURRENT_OUTPUT"
        rm -f "$CURRENT_SOFTWARE_ENC"
        mv "$NEW_SOFTWARE_ENC" "$CURRENT_SOFTWARE_ENC"
        mv "$NEW_SOFTWARE_SIGNATURE" "$CURRENT_SOFTWARE_SIGNATURE"
        echo -e "Success! Loading software version $NEW_VERSION_TEXT ..."
        tar -xzvf "$NEW_OUTPUT" --directory "$OUTPUT_DIRECTORY" &> /dev/null
        change_owner
        ;;
      *)
        echo "ERROR: Not valid version numbers! Great Scott!?!"
        return 1
        ;;
    esac
    ;;
  1)
    # Decrypt the software update
    decrypt "$NEW_SOFTWARE_ENC" "$NEW_OUTPUT" "$KEY"
    tar --extract --file="$NEW_OUTPUT" "$VERSION" &> /dev/null
    mv "$VERSION" "$NEW_VERSION"
    NEW_VERSION_TEXT=$(cat $NEW_VERSION)
    valid_version $NEW_VERSION_TEXT
    if [[ $? == 0 ]]; then
      rm -f "$CURRENT_OUTPUT"
      rm -f "$CURRENT_SOFTWARE_ENC"
      mv "$NEW_SOFTWARE_ENC" "$CURRENT_SOFTWARE_ENC"
      mv "$NEW_SOFTWARE_SIGNATURE" "$CURRENT_SOFTWARE_SIGNATURE"
      echo -e "Success! Loading software version $NEW_VERSION_TEXT ..."
      tar -xzvf "$NEW_OUTPUT" --directory "$OUTPUT_DIRECTORY" &> /dev/null
      change_owner
    else
      return 1
    fi
    ;;
  2)
    # Decrypt the current software
    decrypt "$CURRENT_SOFTWARE_ENC" "$CURRENT_OUTPUT" "$KEY"
    tar --extract --file="$CURRENT_OUTPUT" "$VERSION" &> /dev/null
    VERSION_TEXT=$(cat $VERSION)
    valid_version "$VERSION_TEXT"
    if [[ $? == 0 ]]; then
      rm -f "$NEW_OUTPUT"
      rm -f "$NEW_SOFTWARE_ENC"
      echo -e "Success! Loading software version $VERSION_TEXT ..."
      tar -xzvf "$CURRENT_OUTPUT" --directory "$OUTPUT_DIRECTORY" &> /dev/null
      change_owner
    else
      return 1
    fi
    ;;
  3)
    echo -e "Error: Unable to find any valid software files!"
    return 1;
    ;;
  *)
    echo -e "Error: You really broke things now..."
    return 1;
esac

return 0
}


case "$1" in
  start)
    log_action_msg "Initializing Software Setup" "softwaresetup.sh"
    setup
    if [[ $? == 0 ]]; then
      log_end_msg 0 || true
    else
      echo -e "Failure: Unable to load software!"
      log_end_msg 1 || true
    fi
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

#! /bin/bash -x
### BEGIN INIT INFO
# Provides:          setidentity
# Required-Start:    $remote_fs $syslog     
# Required-Stop:
# Default-Start:     2
# Default-Stop:      
# X-Start-Before:    cron
# Short-Description: Sets the system's unique identifier in /etc/uniqsysidentity.conf
# Description:
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/lsb/init-functions

ID=""
OUTPUT_FILE="/etc/uniqsysidentity.conf"
LOGS="/home/ubuntu/ev/sensor.log"

echo_and_log() {
  echo -e "$1"
  echo -e "${1} ~~ No timestamp available!! >:(" >> "$LOGS"
  # changed owner just in case this script is the first to write the file
  chown "$LOGIN":"$LOGIN" "$LOGS"
}

extract_id () {
  HEX_ADDR1="0x43C20000"
  HEX_ADDR2="0x43C20004"
  HEX_WORD=""

  HEX_WORD="$(/etc/init.d/peek ${HEX_ADDR1})"
  ID=${HEX_WORD:2:10}
  HEX_WORD="$(/etc/init.d/peek ${HEX_ADDR2})"
  ID=${HEX_WORD:2:10}${ID}
  echo "$ID" > $OUTPUT_FILE
  return 0
}

case "$1" in
  start)
    log_action_msg "Setting Unique Identifier" "setidentity.sh"
    echo_and_log "Setting Unique Identifier..." "setidentity.sh"
    extract_id
    if [[ $? == 0 ]]; then
      echo_and_log "Success: Set uniqsysidentity.conf to $ID"
      log_end_msg 0 || true
    else
      echo_and_log "Failure: Unable to set uniqsysidentity.conf!"
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

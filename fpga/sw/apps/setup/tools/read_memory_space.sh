#!/bin/bash 
HEX_INDEX=
HEX_CHARACTER_1=""
HEX_CHARACTER_2=""
AES_KEY=""

for i in {1073742076..1073741823..-8}
do
  for j in {0..4..4}
  do
    printf -v HEX_INDEX '%x\n' "$((${i} - ${j}))" 
    HEX_CHARACTER1="$(./peek 0x${HEX_INDEX})"
    HEX_CHARACTER1="$(echo $HEX_CHARACTER1 | cut -c 10-)"
    HEX_CHARACTER2="${HEX_CHARACTER2}${HEX_CHARACTER1}"
  done
  AES_KEY="${AES_KEY}$(echo -e \\x${HEX_CHARACTER2})"
  HEX_CHARACTER2=""
done  

echo "$AES_KEY"

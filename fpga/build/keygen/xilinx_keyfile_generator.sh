#! /bin/bash

SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
KEYNAME=dummy_key
GENERATE=1

#Check if a keyfile already exists and ask user to regenerate a key
if [ -f $SOURCE/$KEYNAME.nky ]; then
	read -r -p "$SOURCE/$KEYNAME.nky already exists. Would you like to generate a new keyfile? [y/n] " response
	response=${response,,} #response to lowercase
	if [[ $response =~ ^(yes|y)$ ]]; then
		rm $SOURCE/$KEYNAME.nky
	else
		GENERATE=0
	fi
fi
if [ $GENERATE -eq 1 ]; then
	printf 'Device xc7z020;\nKey 0 ' >> $SOURCE/$KEYNAME.nky 
	aes_key="$(openssl enc -aes-256-cbc-hmac-sha1 -k secret -P)"
	printf "${aes_key:26:64}" >> $SOURCE/$KEYNAME.nky 
	printf ';\nKey StartCBC ' >> $SOURCE/$KEYNAME.nky 
	printf "${aes_key:95:32}" >> $SOURCE/$KEYNAME.nky 
	printf ';\nKey HMAC ' >> $SOURCE/$KEYNAME.nky 
	hmac_key="$(openssl enc -aes-256-cbc-hmac-sha1 -k secret -P)"
	printf "${hmac_key:26:64}" >> $SOURCE/$KEYNAME.nky 
	printf ';' >> $SOURCE/$KEYNAME.nky 
fi

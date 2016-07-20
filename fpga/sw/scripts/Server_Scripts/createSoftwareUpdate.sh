#! /bin/bash

# Created by Michael Capone
# 7/20/2016
# Basic script used for packaging files for the software update process.
# The scripts requires four paramters: -AESKey={256 bit key file},
# -RSAkey={private.key file}, -tar={software folder location}, and
# -version={string in the form X.X.X} eg (-version=4.23.3).
# It will return the encrypted software update packaged called
# new_softwareupdate_enc as well as software_enc.sha256. Do NOT alter
# these names. Simply place them into the /var/www/html/files
# directory and the software update mechanism will pull them at the
# set interval

AESKEY=""
RSAKEY=""
SOFTWARE=""
VERSION=""
TARNAME="new_softwareupdate.tar.gz"
VERSIONFILE="version.txt"
ENCRYPTEDOUTPUT="new_softwareupdate.secure"
SIGNATURE="new_softwareupdate.sha256"

usage () {
	echo -e "Usage: createSoftwareUpdate.sh"
	echo -e "\t -AESKey={Path to 256 AES key file}"
	echo -e "\t -RSAKey={Path to 2048 bit RSA private key file}"
	echo -e "\t -software={Path to new software which to compress and encrypt"
	echo -e "\t -version=\"X.X.X\" (e.g. 4.23.3)"
}

for i in "$@"
do 
case $i in
	-AESKey=*)
	AESKEY="${i#*=}"
	AESKEY=$(cat $AESKEY)
	shift
	;;
	-RSAKey=*)
	RSAKEY="${i#*=}"
	shift
	;;
	-software=*)
	SOFTWARE="${i#*=}"
	shift
	;;
	-version=*)
	VERSION="${i#*=}"
	shift
	;;
	*)
	echo "Unknown option $i, showing usage..."
	usage
	exit 1
	;;
esac
done

echo -e "Starting process..."
echo "$VERSION" > $VERSIONFILE
tar -czf $TARNAME $SOFTWARE $VERSIONFILE
openssl enc -aes-256-cbc -e -salt -in "$TARNAME" -out "$ENCRYPTEDOUTPUT" -pass pass:${AESKEY}
openssl dgst -sha256 -sign "$RSAKEY" -out "$SIGNATURE" "$ENCRYPTEDOUTPUT"
echo -e "Complete! Now, place $ENCRYPTEDOUTPUT and $SIGNATURE in the /var/www/html/files directory to begin the update. Please, be careful or you\'ll ruin everything the team has ever accomplished... ;)"




	
	

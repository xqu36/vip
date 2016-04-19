#!/bin/bash
MONITORDIR="/var/www/fup/uploads/"
now=$(date)
echo "$now"
while : 
do
	inotifywait -m -e create --format '%w%f' "${MONITORDIR}" | while read NEWFILE
	do
		sleep 1
		enckey="$(ls -t | grep "enk" | head -n 1) "
		echo "$enckey"
		enckey=${enckey//$'\n'/}
		enctxt="$(ls -t | grep "ent" | head -n 1 )"
		echo "${enctxt} ${enckey}"
		enctxt=${enctxt//$'\n'/}
		if [ ${enckey} -a ${enctxt} ]
		then
			python ./DoubleDecrypt.py ${enckey} ${enctxt}
			#rm $enckey
			#rm $enctxt
			if [ -a "$(ls | grep "${enctxt}.dec")" ]
			then
				#post to mongodb
				FILE="${enctxt}.dec"
				mongoimport -d test -c data $FILE
			fi
		fi	
	done
done

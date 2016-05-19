#!/bin/bash
filename=$1
python DoubleEncrypt.py $filename
enckey="${filename}.enckey"
enctxt="${filename}.enctxt"
sendfile="${filename}.send"
touch $sendfile
printf '***BeginEnc***\n' > $sendfile
cat $enckey > $sendfile
printf '\n***BeginTxt***\n' > $sendfile
cat $enctxt > $sendfile
curl -v -F enk=@$enckey smartcities.gatech.edu/upload 
curl -v -F ent=@$enctxt smartcities.gatech.edu/upload #change this to the server address once its ready
rm $enckey
rm $enctxt
rm $sendfile#

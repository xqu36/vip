#!/bin/bash
filename=$1
python DoubleEncrypt.py $filename
enckey="${filename}.enckey"
enctxt="${filename}.enctxt"
sendfile="${filename}.send"
touch $sendfile
printf '***BeginKey***\n' > $sendfile
cat $enckey > $sendfile
printf '\n***BeginTxt***\n' > $sendfile
cat $enctxt > $sendfile
curl -v -text title=$sendfile -F upl=@$sendfile localhost #change this to the server address once its ready


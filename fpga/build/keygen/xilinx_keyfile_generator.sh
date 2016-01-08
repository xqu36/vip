#! /bin/bash
printf 'Device xc7z020;\nKey 0 ' >> dummy_key.nky 
aes_key="$(openssl enc -aes-256-cbc-hmac-sha1 -k secret -P)"
printf "${aes_key:26:64}" >> dummy_key.nky 
printf ';\nKey StartCBC ' >> dummy_key.nky 
printf "${aes_key:95:32}" >> dummy_key.nky 
printf ';\nKey HMAC ' >> dummy_key.nky 
hmac_key="$(openssl enc -aes-256-cbc-hmac-sha1 -k secret -P)"
printf "${hmac_key:26:64}" >> dummy_key.nky 
printf ';' >> dummy_key.nky 

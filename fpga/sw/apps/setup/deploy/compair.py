import os
os.system('sudo rm /lib/deploy/blacklist.sh')
os.system('dpkg --get-selections | grep -v deinstall > /lib/packs.txt') 
f=open('/lib/deploy/packs.txt','r')
d = open('/lib/deploy/blacklist.sh','a')
d.write("#!/bin/bash")
d.write("\n\n")
i=0
for line in f:
    k=open('/lib/deploy/whitelist.txt','r')
    end = 0
    j = 0
    match = 0
    while end == 0:
        if line[j] == " " or line[j] == "	":
            end = 1
        else:
            j = j+1
    inser = line[:j]
    for line in k.readlines():
        if inser == (line.rstrip()):
            match = 1
            break
        else:
            pass
    if match == 0:
    	d = open('/lib/deploy/blacklist.sh','a')
        d.write("echo 'Y' | sudo apt-get purge ")
        d.write(inser)
        d.write("\n")
        d.close()
        i = i+1
print(i)

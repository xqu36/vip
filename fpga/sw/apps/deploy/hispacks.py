import os
os.system('dpkg --get-selections | grep -v deinstall > /home/ubuntu/deploy/packs.txt')
f=open('/home/ubuntu/deploy/packs.txt','r')
for line in f:
    end = 0
    j = 0
    while end == 0:
        if line[j] == " " or line[j] == "	":
            end = 1
        else:
            j = j+1
    inser = line[:j]
    d = open('/home/ubuntu/deploy/hispacks.txt','a')
    d.write(inser)
    d.write("\n")
    d.close()
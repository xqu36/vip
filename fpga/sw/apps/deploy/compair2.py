import os
os.system('dpkg --get-selections | grep -v deinstall > /mnt/ramdisk/apps/deploy/allpacks.txt') 
os.system('sudo rm /mnt/ramdisk/apps/deploy/deletepacks.sh')
f=open('/mnt/ramdisk/apps/deploy/allpacks.txt','r')
i=0
atall = 0
for line in f:
    k=open('/mnt/ramdisk/apps/deploy/hispacks.txt','r')
    end = 0
    j = 0
    match = 0
    while end == 0:
        if line[j] == " " or line[j] == "	":
            end = 1
        else:
            j = j+1
    inser = line[:j]    #this is the current word in allpacks
    for line in k.readlines():
    	check = line.rstrip()
        if inser == check:
            match = 1
            break
        else:
            pass
    if match == 0:
    	d=open('/mnt/ramdisk/apps/deploy/deletepacks.sh','a')
        d.write("echo 'Y' | sudo apt-get purge ")
        d.write(inser)
        d.write("\n")
        d.close()
        i = i+1
        atall = 1
print("done searching")
os.system('sudo rm /mnt/ramdisk/apps/allpacks.txt')
if i != 0:
    print("%d packages found that were not present on V1.1 build" %i)
    print("\n\nto complete the deployment process, perform one of the actions below:\n")
    response = raw_input("type d to delete packages or k to keep packages and update the package list")
    if response == "d":
        os.system('sudo chmod a+x /mnt/ramdisk/apps/deploy/deletepacks.sh')
        os.system('./mnt/ramdisk/apps/deploy/deletepacks.sh')
        print("to make these changes perminent, alter the 'removing packages' part of the deployment script with the current deletepacks.sh")
    else:
        os.system('sudo rm /mnt/ramdisk/apps/deploy/hispacks.txt')
        os.system('dpkg --get-selections | grep -v deinstall > /mnt/ramdisk/apps/deploy/packs.txt')
        f=open('/mnt/ramdisk/apps/deploy/packs.txt','r')
        for line in f:
            end = 0
            j = 0
            while end == 0:
                if line[j] == " " or line[j] == "	":
                    end = 1
                else:
                    j = j+1
            inser = line[:j]
            d = open('/mnt/ramdisk/apps/deploy/hispacks.txt','a')
            d.write(inser)
            d.write("\n")
            d.close()
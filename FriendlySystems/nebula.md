==== rozlozeni procesoru ====
* Portal,Portal2 - 4
* dev,lb1,lb2,mail,production,testing,Violette,test2,WinTest - 2
* mysql1-slave1-1,-slave2-1 - 1

* dev hlasi pri startu rpcbind (nfs) warningy (ale nabehne a nfs se namountuje:
boot.log:rpcbind: Cannot open '/run/rpcbind/rpcbind.xdr' file for reading, errno 2 (No such file or directory)
boot.log:rpcbind: Cannot open '/run/rpcbind/portmap.xdr' file for reading, errno 2 (No such file or directory)
* podle bugreportu - it should be safe to ignore
* zvlastni je, ze neexistuje ani [[/etc/default/rpcbind,]] ani [[/etc/rpcbind.conf]]
* v [[/etc/init/portmap.conf]] odstraneno -w z parametru rpcbind -> nemelo by zobrazovat warningy

* na lb1 a 2 zvysen server_names_hash_bucket_size v nginx z 32 na 64 (jinak nginx nenabehne)
* u lb1 zmenena jmena block devicu ze sd na hd

==== prenosy serveru ====
* prenaset pres 192.168.50.31:/temp, jsou tam i stare image templaty
* oneimage create mysql1-master2-image.template -d 1

root@nebula:/mnt# cat mysql1-master2-image.template 
NAME          = "mysql1-master2 - Ubuntu 12.04"
PATH          = "/mnt/mysql1-master2.img"
TYPE	      = OS
PERSISTENT    = YES
DEV_PREFIX    = hd
DRIVER	      = raw
BUS	      = virtio

Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-09-16T17:38:53+02:00

====== hooks ======
Created Monday 16 September 2013

http://opennebula.org/documentation:rel4.2:ftguide - virtual machine high availability
http://opennebula.org/documentation:archives:rel2.2:hooks

* zmenena cesta na absolutni (relativni je vuci /var/lib/one/remotes/hooks)
* hook ma parametr remote (YES - pousti se na nodu, NO - pousti se na serveru s nebulou), ale NO je default
* testovani - ubu clear install - image ve stavu clone, nelze pouzit ani disablovat
* VM_HOOK - v arguments pouzit $ID, $VMID se nenahradi

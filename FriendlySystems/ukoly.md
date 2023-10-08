Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2012-06-28T18:35:54+02:00

====== ukoly ======
Created Thursday 28 June 2012

* lucid - node1-4, web1a, mysql1a, nix
* precise - dev, testing, production, nebula, lbcka, mail, apps, eye, nove mysql

===== upgrade =====
* dalsi ssh se spusti na portu 1022
* povolit znova bash-completion v [[/etc/bash.bashrc]]
* nastavit znova [[/etc/vim/vimrc]]
* zkontrolovat [[/etc/apt/apt.conf.d/50unattended-upgrades]]
* nody - pokud pada na no bootable device, zmenit dev_prefix na hd

==== eye ====
* odstrani freenx - vyzkouset nxclient, pripadne nahradit nejakym novejsim balikem
* promazat locales, at se generuje jen en_US
* nxserver - pridan ppa repozitar, zaktualizovano
	* nastaveno pro xfce, odstraneno unity a gnome
	* gksu recommends gnome-keyring
	* virt-manager recommends gnome-icon-theme

===== zalohovani mysql =====
* mysql1-master2 - [[/srv/backup]] neni na nfs
* zkontrolovat na mysqlkach ntp - melo by synchronizovat z lb

webservery:
vytvorit 2 stroje v nebule (web1a - docasna vnitrni adresa, web1b - vnitrni adresa o 1 vyssi, nez stavajici web1a), zkopirovat konfiguraci nfs (data i konfigurace apache), konfiguraci php, nastavit loadbalancig v nginx na lb1 (+ lb2)

zjištění:
* ntp nelze jednoduše omezit, aby nenaslouchalo na všech adresách
	* nahrazeno openntpd, lb1 - synchronizovano z debian poolu, nasloucha na vnitrnim rozhrani, ostatni jenom clienty (nenaslouchaji), synchronizuji z lb1
	* na lb2 (az pobezi) udelat totez
	* openntpd - chyba - pri prilis velkem rozdilu hodin 'adjtime failed: Invalid argument' - vyreseno jednorazovym volanim ntpdate (https://bbs.archlinux.org/viewtopic.php?id=40574)
	* ntpdate - pokud neni server synchronizovan, neceka, vypise 'no server suitable for synchronization found'
* snmpd - nalezena chyba v /etc/default/snmpd:
	* SNMPDOPTS='-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid 0.0.0.0' - pokud v /etc/snmp/snmpd.conf nenastavim agentaddress nasloucha vsude,
		* kdyz nastavim, nenastartuje - parametr se neshoduje s konfem

* podivat se znovu na snmp, aby nehlasilo nesmyslne thresholdy u sitovych prenosu
* nastudovat analyzu bezpecnosti site, nastroje - dsniff, snort, ethercap

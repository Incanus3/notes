Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-03T21:45:00+01:00

====== amanda ======
Created Sunday 03 November 2013

http://www.zmanda.com/downloads/community/Amanda/3.3.3/Ubuntu-12.04/
http://wiki.zmanda.com/index.php/How_Tos
http://wiki.zmanda.com/man/3.3.0/amanda.8.html
http://wiki.zmanda.com/index.php/Troubleshooting

===== mysql =====
http://wiki.zmanda.com/index.php/Zmanda_Recovery_Manager_for_MySQL_Users_Manual
http://wiki.zmanda.com/index.php/Quick_Start_Example

===== installation & configuration =====
http://wiki.zmanda.com/index.php/GSWA/Build_a_Basic_Configuration
http://ubuntuforums.org/archive/index.php/t-1525491.html - bugs in ubuntu amanda package
* zmenit vlastnictvi /etc/amanda, /var/amanda, /var/lib/amanda na backup:backup
* su backup
* prekopirovat templaty z debiani verze /usr/share/doc/amanda-server/examples do /var/lib/amanda/template.d a /etc/amanda/template.d, rozbalit .gz
* upravit cesty v /usr/lib/amanda/perl/Amanda/Paths.pm dole:
'''
#$amdatadir = "/usr/share/amanda";
$amdatadir = "/var/lib/amanda";
#$localstatedir = "/var/lib";
$localstatedir = "/var";
'''

* mkdir -p /var/lib/amanda/vtapes/test
* amserverconfig test --template harddisk --mailto jakub --tapedev '/var/lib/amanda/vtapes/test'
* cd /usr/lib/amanda
* chmod u+s calcsize dumper killpgrp planner rundump runtar
* amcheck test
* amdump test
* amreport test - report of the last dump
* amoverview test - counts and types of dumps on each host, disk and date
http://wiki.zmanda.com/index.php/How_To:Set_Up_Virtual_Tapes
http://wiki.zmanda.com/index.php/FAQ:Should_I_use_a_holdingdisk_when_the_final_destination_of_the_backup_is_a_virtual_tape%3F

http://wiki.zmanda.com/index.php/How_To:Set_up_transport_encryption_with_SSH
* **host entry in disklist must match the first hostname in /etc/hosts exactly, so if disklist is**
**dev** <dir> <dumptype>
and /etc/hosts line is
<ip> **dev.domain.foo** dev
**this won't work**

==== client ====
chown -R amandabackup:disk /var/amanda/
su amandabackup
touch /var/amanda/amandates

===== recovery =====
http://wiki.zmanda.com/index.php/How_To:Recover_Data
https://bugs.launchpad.net/ubuntu/+source/amanda/+bug/1074574
* there's a bug in 3.3.0:
	* amrecover - can't talk to tape server: service amidxtaped
	* fix it according to https://bugs.launchpad.net/ubuntu/+source/amanda/+bug/1077105
* amrecover(8), which lets you restore particular files or directories and is the most automated
	* Amrecover is interactive, and runs on client or server, as root
	* echo "localhost root amindexd amidxtaped" >> /var/backups/.amandahosts
		* allow root to run recovery commands (only the first time)
	* cat /etc/amanda/weekly/disklist - print list of backed-up hosts and directories
	* enter empty directory
	* amrecover weekly (or whatever configuration we want)
	* help
	* sethost web1a (or what host we want to recover)
	* setdisk /var/www (or what we want to recover)
	* now we can use ls, cd, ...
	* history - find the date we want, copy the descriptor - e.g. 2013-11-04-19-36-11
	* setdate 2013-11-04-19-36-11 (or what date we want to recover to)
	* add(x) <file> | delete(x) <file> | clear
	* extract, <enter>, <enter>
	* quit

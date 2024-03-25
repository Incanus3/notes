# EYE:
* all - 0.0.0.0
	* 22/tcp - sshd - open
	* 25/tcp - smtp - closed
	* 67/udp - bootps - dhcp server / dns cache (dnsmasq) - closed
* local - 192.168.50.2
	* 161/udp - snmpd - open from apps (zenoss)
* virbr0 - 192.168.122.1
	* 53/tcp,udp - dns (dnsmasq) - closed

# NIX:
* all - 0.0.0.0
	* 22/tcp - sshd - open
	* 25/tcp - smtp - open from portal1, portal2
	* 67/udp - bootps (dnsmasq) - closed
	* 111/tcp,udp - rpc.portmap - default - open for br1
	* 817/tcp - rpc.statd - not default, not found by 'grep 817 /etc/* -R' !!! - closed
	* 2049/tcp,udp - nfs - default - open for br1
	* 4000/tcp,udp - rpc.statd - set in /etc/default/nfs-common - open for br1
	* 4001/tcp,udp - nfs - set in /etc/modprobe.d/nlockmgr.conf - open for br1
	* 4002/tcp,udp - rpc.mountd - set in /etc/default/nfs-kernel-server - open for br1
	* 9102/tcp - bacula-fd - open from apps (bacula-director)
	* 9103/tcp - bacula-sd - open from eye (bacula-mon), apps (bacula-dir), web1a, mysql1a, mysql1-master[12] (bacula-fd)
* local - 192.168.50.1
	* 161/udp - snmpd - open from apps (zenoss)
* vibr0 - 192.168.122.1
	* 53/tcp,udp - dns (dnsmasq) - closed

# APPS:
* all - 0.0.0.0
	* 1/raw - zenping.py - zenoss
	* 162/udp - zentrap.py - zenoss - closed
	* 514/udp - zensyslog.py - zenoss - closed
	* 3307 - mysqld - zenoss - closed
	* 8080/tcp - runzope - zenoss - set in /usr/local/zenoss/zenoss/etc/zope.conf - open from eye, lb1, lb2
	* 8081,8789/tcp - zenhub.py - zenoss - closed
* local - 192.168.50.3
	* 22/tcp - sshd - open
	* 9101/tcp - bacula-dir - open from eye (bat, bacula-mon)
	* 161/udp - snmpd - open from localhost, eye ???
* localhost - 127.0.0.1
	* 25/tcp - smtpd - closed
	* 3306/tcp - mysqld - closed
	* 8100/tcp - runzeo.py - zenoss - closed

# NEBULA:
* all - 0.0.0.0
	* 111/tcp,udp - rpcbind - open
	* 677/udp - rpcbind - closed
	* 2633/tcp - oned - closed
	* 9869/tcp - sunstone-server - open from eye, lb1, lb2
	* 43336/tcp - rpc.statd - closed
	* 43490/udp - rpc.statd - closed
* local - 192.168.50.4
	* 22/tcp - sshd - open
	* 161/udp - snmpd - open from apps
* localhost - 127.0.0.1
	* 864/udp - rpc.statd - closed
* rpc.statd belongs to nfs-common -> is used by the nfs-client

# LB1:
* all - 0.0.0.0
	* 22/tcp - sshd - open
	* 694/udp - heartbeat - open from lb2
	* 4743/tcp - openhpid - closed
	* 45086/udp - heartbeat - closed
	* 46791/udp - haproxy - closed
* 95.168.199.21:3306/tcp - haproxy - mysql proxy - open from 95.168.199.11, 95.168.199.23, 95.168.199.19 - why does it listen on public ip ?!!
* 95.168.199.22:3306/tcp - -||-
* 95.168.199.13:9869/tcp - haproxy - sunstone web proxy - open
* 95.168.199.13:8080/tcp - haproxy - zenoss web proxy - open
* 95.168.199.17:80/tcp - haproxy - www proxy ??? - open
* 95.168.199.21:80/tcp - haproxy - web1a proxy - open
* 192.168.50.51:123 - ntpd - open for local network
* 192.168.50.51:161/udp - snmpd - open from apps

# WEB1A:
* all - 0.0.0.0
	* 22/tcp - sshd - open
	* 80/tcp - apache - open
	* 111/tcp,udp - portmap - nfs-client - closed
	* 778/udp - rpc.statd - nfs-client - closed
	* 46708/tcp - -||- - closed
	* 50388/udp - -||- - closed
* local - 192.168.50.101
	* 161/udp - snmpd - open from apps
	* 9102/tcp - bacula-fd - open from apps (bacula-dir), eye (bacula-mon)
* localhost - 127.0.0.1
	* 25/tcp - smtp - postfix

#MYSQL1A
* all - 0.0.0.0
	* 111/tcp,udp - portmap - nfs-client
	* 795/udp - rpc.statd - nfs-client
	* 3306/tcp - mysqld - open from mysql1b (replikace), lb1, lb2 (proxy), apps (zenoss monitoring), eye (management)
	* 48763/udp - rpc.statd - nfs-client
	* 54898/tcp - -||-
* local - 192.168.50.103
	* 22/tcp - sshd - open
	* 161/udp - snmpd - open from apps
	* 9102/tcp - bacula-fd - open from apps (bacula-dir), eye (bacula-mon)
* port 9102 - open from lb1, lb2 (mysql-watchdog), but not listening !!
* from nix, nas all ports open - nfs - VYRESIT !!!

#NODE1
* all - 0.0.0.0
* 67/udp - bootps - dnsmasq - closed
* 68/udp - bootpc - dhclient3 - closed
* 111/tcp,udp - portmap - nfs-client - open for local network
* 975/upd - rpc.statd - nfs-client - closed
* 43058/udp - -||- - closed
* 49205/tcp - -||- - closed
* local - 192.168.50.201
	* 22/tcp - sshd - open
	* 161/udp - snmpd - open from apps
	* 9103/tcp - bacula-sd - open from apps
* vibr0 - 192.168.122.1
	* 53/tcp,udp - domain - dnsmasq - closed
* localhost - 127.0.0.1
	* 5900-5903/tcp - kvm-vnc - closed

#NODE2
* all - 0.0.0.0
* 68/udp - bootpc - dhclient3 - closed
* 111/tcp,udp - portmap - nfs-client - open for local net
* 614/udp - rpc.statd - closed
* 54257/tcp - -||- - closed
* 60562/udp - -||- - closed
* local - 192.168.50.202
	* 22/tcp - sshd - open
	* 161/udp - snmpd - open from apps
	* 9103/tcp - bacula-sd - closed (9102 open though)
* localhost - 127.0.0.1
	* 5900-5906/tcp - kvm-vnc - closed
* nfs-server ports open though no nfs-server is running

#NODE3
firewall - temporarily allowed all connection from local net - opennebula, plus all connections from nix accepted - nfs
* all - 0.0.0.0
* 68/udp - bootpc - dhclient3 - closed
* 111/tcp,udp - portmap - nfs-client - open from local net
* 977/udp - rpc.statd - nfs-client - closed
* 5900,5904/tcp - kvm-vnc - open (5900-5920)
* 45990/tcp - rpc.statd - nfs-client - closed
* 46872/udp - rpc.statd - nfs-client - closed
* 192.168.50.203
	* 161/udp - snmpd - open from apps
	* 22/tcp - sshd - open

#NODE4
firewall - temporarily allowed all connection from local net - opennebula, plus all connections from nix accepted - nfs
* all - 0.0.0.0
	* 67/udp - pootps - dnsmasq - closed
	* 68/udp - pootpc - dhclient3 - closed
	* 111/tcp,udp - portmap - nfs-client - open from local net
	* 968/udp - rpc.statd - nfs-client - closed
	* 5901,5902,5905/tcp - vnc - kvm - open (5900-5920)
	* 51520/tcp - rpc.statd - nfs-client - closed
	* 52676/udp - -||- - closed
* local - 192.168.50.204
	* 22/tcp - sshd - open
	* 161/udp - snmpd - open from apps
* vibr0 - 192.168.122.1
	* 53/tcp,udp - domain - dnsmasq - closed

#MYSQL1-MASTER1
firewall - accepts all from nas - nfs
tcp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:840			664/rpc.statd		closed
udp        0      0 0.0.0.0:43436			rpc.statd			closed
tcp        0      0 0.0.0.0:51289			rpc.statd			closed
tcp        0      0 192.168.50.151:22		sshd			open
udp        0      0 192.168.50.151:161	snmpd			open from apps
tcp        0      0 192.168.50.151:3306	mysqld			open
tcp        0      0 192.168.50.151:9102	bacula-fd			open from apps (bacula-dir), eye (bacula-mon)

#MYSQL1-MASTER2
firewall - accepts all from nas - nfs
tcp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:829			rpc.statd			closed
tcp        0      0 0.0.0.0:52826			rpc.statd			closed
udp        0      0 0.0.0.0:60369			rpc.statd			closed
tcp        0      0 192.168.50.152:22		sshd			open
udp        0      0 192.168.50.152:161	snmpd			open from apps
tcp        0      0 192.168.50.152:3306	mysqld			open
tcp        0      0 192.168.50.152:9102	bacula-fd			open from apps (bacula-dir), eye (bacula-mon)

#MYSQL1-SLAVE1-1
firewall - accepts all from nas - nfs
tcp        0      0 0.0.0.0:111			portmap   		closed
udp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:853			rpc.statd			closed
tcp        0      0 0.0.0.0:58979			rpc.statd			closed
udp        0      0 0.0.0.0:59393			rpc.statd			closed
tcp        0      0 192.168.50.153:22		sshd			open
udp        0      0 192.168.50.153:161	snmp			open from apps
tcp        0      0 192.168.50.153:3306	mysqld			open

#MYSQL1-SLAVE2-1
firewall - accepts all from nas - nfs
tcp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:111			portmap			closed
udp        0      0 0.0.0.0:851			rpc.statd			closed
tcp        0      0 0.0.0.0:36047			rpc.statd			closed
udp        0      0 0.0.0.0:40920			rpc.statd			closed
tcp        0      0 192.168.50.154:22		sshd			open
udp        0      0 192.168.50.154:161	snmpd			open from apps
tcp        0      0 192.168.50.154:3306	mysqld			open

The **rpc.statd** server implements the NSM (Network Status Monitor) RPC protocol. This service is somewhat misnomed, since it doesn't actually provide active monitoring as one might suspect; instead, NSM implements a reboot notification service. It is used by the NFS file locking service, rpc.lockd, to implement lock recovery when the NFS server machine crashes and reboots.

The **rpc.mountd** program implements the NFS mount protocol. When receiving a MOUNT request from an NFS client, it checks the request against the list of currently exported file systems. If the client is permitted to mount the file system, rpc.mountd obtains a file handle for requested directory and returns it to the client.  

The **rpc.lockd** (nlockmgr) program starts the NFS lock manager (NLM) on kernels that don't start it automatically. However, since most kernels do start it automatically, rpc.lockd. is usually not required. Even so, running it anyway is harmless.

The **rpcbind** utility is a server that converts RPC program numbers into universal addresses.  It must be running on the host to be able to make RPC calls on a server on that machine.
When an RPC service is started, it tells rpcbind the address at which it is listening, and the RPC program numbers it is prepared to serve.  When a client wishes to make an RPC call to a
given program number, it first contacts rpcbind on the server machine to determine the address where RPC requests should be sent.

**Portmap** is a server that converts RPC program numbers into DARPA protocol port numbers. It must be running in order to make RPC calls.
When an RPC server is started, it will tell portmap what port number it is listening to, and what RPC program numbers it is prepared to serve. When a client wishes to make an RPC call to a given program number, it will first contact portmap on the server machine to determine the port number where RPC packets should be sent. 

http://wiki.debian.org/SecuringNFS

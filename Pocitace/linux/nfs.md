Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2012-07-29T13:58:40+02:00

====== nfs ======
Created Sunday 29 July 2012

/etc/exports
exportfs, showmount, nfsstat, rpcinfo -p
http://forums.freebsd.org/showthread.php?t=5123
http://bryanw.tk/2012/specify-nfs-ports-ubuntu-linux/
http://wiki.debian.org/SecuringNFS

## /etc/default/nfs-common
STATDOPTS="--port 4000 --outgoing-port 4001"

## /etc/default/nfs-kernel-server 
RPCMOUNTDOPTS="--manage-gids --port 4002"

 # /etc/modprobe.d/local.conf
 options lockd nlm_udpport=4003 nlm_tcpport=4003
 options nfs callback_tcpport=4004

==== nastaveni firewallu u clienta ====
$iptables -A INPUT -p tcp -s 192.168.0.1 --sport 111 -j ACCEPT #nfs from nix                      
$iptables -A INPUT -p tcp -s 192.168.0.1 --sport 2049 -j ACCEPT #nfs from nix                     
$iptables -A INPUT -p tcp -s 192.168.0.1 --sport 4002 -j ACCEPT #nfs from nix                     
$iptables -A INPUT -p udp -s 192.168.0.1 --sport 111 -j ACCEPT #nfs from nix                      
$iptables -A INPUT -p udp -s 192.168.0.1 --sport 2049 -j ACCEPT #nfs from nix                     
$iptables -A INPUT -p udp -s 192.168.0.1 --sport 4002 -j ACCEPT #nfs from nix 

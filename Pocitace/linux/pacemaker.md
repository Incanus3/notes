Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2012-07-16T17:02:05+02:00

====== pacemaker ======
Created Monday 16 July 2012

==== corosync ====
* instaluje se jako zavislost pacemakeru
* /etc/default/corosync - START=yes
* /etc/corosync/corosync.conf:
	* totem
		bindnetaddr: 192.168.0.0    # podsit
		mcastaddr: 239.1.1.1
		mcastport: 5405
	* service
		ver: 1 # if using pacemaker 1.1, 0 if using 1.0
	* logging
		to_logfile: yes
		logfile: /var/log/corosync/corosync.log
* firewall
	* povolit udp 5404:5405 pro vnitrni sit (-i eth1), nenastavovat source (nefunguje multicast)
* netstat -g
IPv6/IPv4 Group Memberships
eth0            1      239.1.1.1
* grepnout log na totem a 'config file' jestli nedoslo k chybe

==== heartbeat ====
/etc/ha.d/ha.cf, authkeys
/etc/logd.cf
/etc/init.d/firewall

==== pacemaker ====
* loguje do syslogu
crm configure show
crm configure property stonith-enabled=false
crm configure property no-quorum-policy=ignore
crm configure rsc_defaults resource-stickiness=100
crm_verify -L
crm configure primitive Web1IP ocf:heartbeat:IPaddr2 \
	params ip=<ip> cidr_netmask=27 \
	op monitor interval=30s
crm configure primitive MySQL1IP ocf:heartbeat:IPaddr2 \
	params ip=<ip> cidr_netmask=27 \
	op monitor interval=30s
crm configure primitive ClusterIP ocf:heartbeat:IPaddr2 \
	params ip=<ip> cidr_netmask=32 \
	op monitor interval=30s
crm configure primitive WebSite ocf:heartbeat:apache \
	params configfile=/etc/httpd/conf/httpd.conf \
	statusurl="http://localhost/server-status" \
	op monitor interval=1min
crm configure primitive RabbitIP ocf:heartbeat:IPaddr2 \
	params ip=<ip> cidr_netmask=24 \
	op monitor interval=30s
crm configure primitive RabbitMQ ocf:rabbitmq:rabbitmq-server \
	op start interval="0" timeout="600s" \
	op stop interval="0" timeout="120s"
crm configure primitive nginx ocf:heartbeat:nginx op start timeout=40s op stop timeout=60s
crm configure colocation website-with-ip inf: WebSite ClusterIP
crm configure order apache-after-ip mandatory: ClusterIP WebSite
crm configure location prefer-pcmk-1 WebSite 50: pcmk-1			# prefered location

crm configure show
crm_mon
crm resource status ClusterIP
crm resource move WebSite pcmk-1
crm resource unmove WebSite
crm_simulate

* vypsani resourcu:
crm ra classes
crm ra list ocf heartbeat/pacemaker

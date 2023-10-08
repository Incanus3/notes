Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-01T21:35:27+01:00

====== zabbix ======
Created Friday 01 November 2013

===== instalace agenta =====
wget http://repo.zabbix.com/zabbix/2.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.0-1precise_all.deb
dpkg -i zabbix-release_2.0-1precise_all.deb
aptitude update
aptitude install zabbix-agent
sed -i 's/Server=127.0.0.1/Server=192.168.50.3/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive=192.168.50.3/' /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix server/Hostname=`hostname`/" /etc/zabbix/zabbix_agentd.conf
/etc/init.d/zabbix-agent restart
sed -i 's/# povolene porty/# povolene porty\n$iptables -A INPUT -p tcp --destination-port 10050 -s 192.168.50.3 -j ACCEPT # zabbix z apps/' /etc/init.d/firewall
/etc/init.d/firewall restart

===== monitoring apache =====
https://www.zabbix.com/wiki/templates/apache - method 2

===== monitoring mysql =====
https://www.zabbix.com/documentation/1.8/manual/config/user_parameters

===== postfix =====
http://sys4.de/en/blog/2013/08/06/postfix-deliverability-monitoring-with-zabbix/
https://www.zabbix.com/wiki/howto/monitor/mail/postfix/monitoringpostfix
http://middleswarth.net/content/adding-postfix-template-zabbix

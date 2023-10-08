Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-03T16:59:58+01:00

====== fail2ban ======
Created Sunday 03 November 2013

http://www.fail2ban.org/wiki/index.php/MANUAL_0_8
* iredmail fail2ban configuratoin is in /etc/fail2ban/jail.local
* filters are in /etc/fail2ban/filter.d/(dovecot|postfix|roundcube).iredmail.conf
* iptables rules are in /etc/fail2ban/action.d/iptables(-multiport)?.conf

* although there are no commands to delete non-fail2ban chains, when fail2ban started after firewall, it deletes the chains anyway -> start after firewall

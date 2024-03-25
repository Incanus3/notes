===== vytvoreni hostingu =====
groupadd -g 5050 client50
mkdir /var/www/clients/client50
useradd -d /var/www/clients/client50/web77 -g 5050 -m -s /bin/sh -u 5077 web77

===== rotace logu v apachi =====
* http://httpd.apache.org/docs/2.4/logs.html
* logy ve /var/log/apache2 se rotuji
* logy vhostu ve /var/www ne, moznosti
	* klasickou rotaci je treba provadet s vypnutym apachem - neprilis sikovne
	* nastavit v kazdem vhostu (nebo jen v tech problematickych) piped log
		* CustomLog "|/usr/local/apache/bin/rotatelogs /var/log/access_log 86400" common
		* treba nastavovat ve vsech vhostech, vytvori pro kazdy vhost proces pro rotatelogs
	* zatim neresit - nedeje se moc rychle

TESTY - pri cem se appache posere a jak moc:
	temp:
pokud neni zapisovatelny vhost tmp, zapisuje se do system tmp
pokud neni zapisovatelny ani ten, upload selze

	log:
pokud neexistuje log soubor, je vytvoren
pokud neexistuje slozka, nevytvori se, log se nezapise (ani do globalniho)
pokud neexistuje slozka uz pri startu apache, apache nenabehne
log se zapisuje pod rootem (i pri pouziti mod-itk), takze by nemelo dojit k problemu s opravnenim

	document root:
pokud neexistuje, nebo neni zapisovatelny, nefunguje jen vhost, apache nabehne a ostatni vhosti funguji

===== monitorovani =====
* nastavit u apache server-status stranku, na ni by mely byt videt jednotlivi workery vhostu

* logy apache na access podle VH
cat /var/log/apache2/vhosts_access.log | awk '{ SUM[$1] += 1} END { for ( x in SUM ) {print SUM[x], x } }'|sort -n|tail
* logy apache na access podle IP
cat /var/log/httpd/access.log | awk '{ SUM[$1] += 1} END { for ( x in SUM ) {print SUM[x], x } }'|sort -n|tail
* logy apache na traffic podle VH v MB
cat /var/log/httpd/access_log | awk '{ SUM[$1] += $11} END { for ( x in SUM ) {print SUM[x]/1024/1024, x } }'|sort -n|tail
* logy apache na traffic podle IP v MB
cat /var/log/httpd/access_log | awk '{ SUM[$2] += $11} END { for ( x in SUM ) {print SUM[x]/1024/1024, x } }'|sort -n|tail
* zobrazeni aktivnich klientu na apache s prekladem PTR
for i in `apachectl fullstatus|grep ' W '|awk '{print $11}'`; do host $i; done |sort|uniq -c |sort -n
* pametove naroky apache
ps -ylC httpd | awk '{x += $8;y += 1} END {print "Apache Memory Usage (MB): "x/1024; print "Average Proccess Size (MB): "x/((y-1)*1024)}'

http://freecode.com/projects/apachetop - curses-based top-like display for Apache information, including requests per second, bytes per second, most popular URLs, etc. 
* server-status - informacni stranka apache - informace o jednotlivych workerech

* monitorovani prenesenych dat - mod_cband
* mod_rpaf - pokud je %h adresa proxy a X-Forwarded-For header existuje a neni to adresa proxy, nastavi podle ni X-host a %h pro dalsi zpracovani
LoadModule rpaf_module libexec/apache2/mod_rpaf-2.0.so

RPAFenable On
RPAFsethostname On
RPAFproxy_ips 127.0.0.1 10.0.0.1
RPAFheader X-Forwarded-For

===== iRedMail =====
* iRedMail nema zadnou vlastni slozku - je to v podstate jen pohodlny bundle postfixu, spamassassinu, antiviru a roundcube

[*] mail.friendlysystems.cz - domenovy kos
	lze - pomoci catchall aliasu ve virtual_alias_maps, je pak ale potreba, aby kazdy normalni uzivatel mel alias sam na sebe, jinak bude vsechno chodit do catchall

==== Materialy ====
http://code.google.com/p/iredmail/source/browse/extra/iRedMail.tips

=== upgrady ===
- verze - /etc/iredmail-release
http://www.iredmail.org/wiki/index.php?title=Main_Page

=== backup/restore ===
http://www.iredmail.org/forum/topic577-iredmail-support-faq-backuprestore-procedure-for-iredmail-using-mysql-database.html
http://www.iredmail.org/wiki/index.php?title=IRedMail/FAQ/Backup

=== high availability ===
http://www.iredmail.org/wiki/index.php?title=Cluster/General.Resource
http://www.iredmail.org/wiki/index.php?title=Master-master_high-availability_failover_iRedMail_system_using_GlusterFS

==== Konfigurace ====
- na konci apache2.conf informace pro prihlaseni k mysql
- v conf.d nastaveni prav
- zbytek v sites-enabled/default-ssl - pouze aliasy do slozek s aplikacemi -
  cluebringer, mail (webmail, roundcube), phpmyadmin, awstats, iredadmin

=== roundcube ===
* umisteni - /usr/share/apache2
* obsahuje slozku s logy
* config/main.inc.php: $rcmail_config['debug_level'] = 1;

* error: [24-Aug-2013 22:58:42 +0200]: DB Error: Configuration error. Unsupported database driver:  in /usr/share/apache2/roundcubemail-0.9.3/program/lib/Roundcube/rcube_db.php on line 75 (GET /mail/)
	* v db.inc.php se pouzival mysqli driver, zmena na mysql driver ale nepomuze
	* zkusit postupne upgradovat po verzich (http://sourceforge.net/projects/roundcubemail/files/roundcubemail/)
	* zaloha databaze je v /root/mysql-db-roundcubemail.sql

=== iRedAdmin ===
- umisteni - /usr/share/apache2

=== iRedAPD ===
- umisteni - /opt

=== awstats ===
http://awstats.sourceforge.net/
- nasloucha na https://mail.friendlysystems.cz/awstats/awstats.pl - webove statistiky
- https://mail.friendlysystems.cz/awstats/awstats.pl?config=smtp - mailove statistiky
- prihlaseni - webmaster@vprostoru.cz
- konfigurace - /etc/awstats

=== cluebringer ===
https://www.policyd.org/
- konfigurace - /etc/cluebringer

=== KONFIGURACE JAKO RELAY ===
v [[/etc/postfix]] na apps, vyzaduje libsasl2-2

=== SEND MAIL FROM CMD ===
echo "This will go into the body of the mail." | mail -s "Hello world" jakub.kalab@friendlysystems.cz
echo "This goes into the body" | mutt -a 'attachment.tar.bz2' -s "Subject" -- jakubkalab@gmail.com

== Postfix ==
- queued delete messages according to sender/receiver (taken from man postsuper)
mailq | tail -n +2 | grep -v '^ *(' | awk  ´BEGIN { RS = "" }
    # $7=sender, $8=recipient1, $9=recipient2 <-- !!!
    { if ($8 == "user@example.com" && $9 == "")
          print $1 }
´ | tr -d '*!' | postsuper -d -
- use e.g. $7 ~ /@slehofer\.cz/ to test substring of sender
- remove last row after ` and print $7/8 to test

== Mutt ==
- smazat soubory starsi nez:
  D (delete-pattern), zadat ~d -25/3/2014

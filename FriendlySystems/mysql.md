===== apps =====
* zabbix pouziva InnoDB engine, /var/lib/mysql/ibdata1 stale roste - zvetsit misto, pripadne upravit nastaveni toho, jak dlouho zabbix informace uchovava

===== prenos useru =====
* rozchodit rvm, nainstalovat server-management gem, highline
* migrate-db-users.rb > users-mysq1-master1.sql
* sort users-mysql1-master1.sql | egrep -v '^$|^--|root|replicator|debian' > users-mysql1-master1-sorted.sql # seradit, odstranit prazdne radky, komentare, radky s usery root, replicator, ...
* scp na eye
* diff users-mysql1-master1-sorted.sql users-mysql1-master2-sorted.sql | cut -c 3- | grep -v ',' > new-users-mysql1-master2.sql # spustit nejdriv samotny diff a zjistit, jestli tam veci jenom pribyvaji
* scp zpatky
* provest

* v migrate scriptu je chyba - GRANT ALL PRIVILEGES ON `friendlysystems_cz_management`.* TO 'u0046'@'192.168.50.51' - prvni uvozovky by mely byt jen apostrofy, ne backticky
* rychle lze vyresit pomoci mv new-users.sql new-users.sql.bkp && cat new-users.sql.bkp | tr '`' "'" > new-users.sql       # (dvojita, jednoducha, dvojita)
* GRANT nepouziva uvozovky kolem nazvu tabulky
* chybi stredniky - sed -ri 's/([^;])$/\1;/g' new-users.sql

===== replikace =====

=== dotazy na Honzu ===
- pripad hot standby, nemuzu si dovolit, vypnout vsechny mastery najednou,
	potrebuju provest switchover, jak to udelam?
- jak to, ze mi nevadi zpozdeni pri replikaci:
	- mam proxy, ktera smeruje destruktivni dotazy na master, zbytek na slavy
	- poslu hned za sebou 2 dotazy - destruktivni a nedestruktivni
	- nedestruktivni muze dorazit na slave driv, nez se destruktivni zreplikuje
	- tykaji-li se dotazy stejnych dat, dojde k nekonzistenci

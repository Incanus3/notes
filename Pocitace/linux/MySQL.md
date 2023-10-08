Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2012-07-16T17:03:52+02:00

====== MySQL ======
Created Monday 16 July 2012

* mysql error numbers - http://dev.mysql.com/doc/refman/5.5/en/error-messages-server.html

===== root password recovery =====
* stop mysql daemon
mysqld_safe --skip-grant-tables
mysql --user=root mysql
update user set Password=PASSWORD('new-password') where user='root';
flush privileges;
exit;

===== table repair =====
Go to your data folder and try running myisamchk -r <table_name>. You should stop MySQL process first.

===== InnoDB data file growing =====
http://stackoverflow.com/questions/3456159/how-to-shrink-purge-ibdata1-file-in-mysql
http://dev.mysql.com/doc/refman/5.5/en/innodb-multiple-tablespaces.html
http://dev.mysql.com/doc/refman/5.5/en/innodb-data-log-reconfiguration.html
http://vdachev.net/2007/02/22/mysql-reducing-ibdata1/

• SELECT table_schema, table_name FROM INFORMATION_SCHEMA.TABLES WHERE engine = 'innodb'; - find InnoDB tables


http://dev.mysql.com/doc/refman/5.0/en/mysqlshow.html

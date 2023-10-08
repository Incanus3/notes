Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-03-20T12:29:37+01:00

====== replikace ======
Created Wednesday 20 March 2013

http://exploremysql.blog.com/?p=36 - replicate-ignore-db=mysql ignoruje jenom statementy, ktere se vykonaly, kdyz byla zvolana databaze mysql pomoci USE, ostatni se replikuji dal

===== nastaveni replikace, kdyz uz jsou na masteru data =====
* zastavit mastera - FLUSH TABLES WITH READ LOCK; (zamek se uvolni pri ukonceni klienta - nechat tedy bezet, dokud neudelam dump)
* zjistit pozici jeho binlogu - SHOW MASTER STATUS; (nebo mysqldump --master-data)
* mysqldump -u root -p --add-drop-database --all-databases --log-error=errors.log --master-data > master1-dump.db (--master-data by mel pridat do dumpu spravny CHANGE MASTER TO)

Note that the --master-data option only includes MASTER_LOG_FILE and MASTER_LOG_POS arguments of the "CHANGE MASTER TO" statement; you'll likely want to edit the dump to include MASTER_HOST, MASTER_USER and MASTER_PASSWORD values when importing to a fresh slave server (or realize that you'll need to re-issue a CHANGE MASTER TO statement after the import).

CHANGE MASTER TO
	MASTER_HOST='mysql1-master2',
	MASTER_PORT=3306,
	MASTER_USER='replicator',
	MASTER_PASSWORD='LQ09zBw6qTmJ',
	MASTER_LOG_FILE='master-bin.000272',
	MASTER_LOG_POS=3817053;


===== notes =====
SQL replication:
- install mysql
- set log_bin and server-id in /etc/mysql/my.cnf (on master)
- create replication user (on master):

mysql> CREATE USER repl_user;

mysql> GRANT REPLICATION SLAVE ON *.*
	TO repl_user@'<IP (ne hostname!!!)>' IDENTIFIED BY 'repl_pass';

- set server-id, relay_log and relay_log_index in my.cnf (on slave)
- on slave execute:
slave> CHANGE MASTER TO
	MASTER_HOST = 'lb1-test',
	MASTER_PORT = 3306,
	MASTER_USER = 'repl_user',
	MASTER_PASSWORD = 'repl';

slave> START SLAVE;

- view binlog status - SHOW MASTER STATUS
- SHOW BINLOG EVENTS IN '<logfile>'[\G]
- RESET MASTER - clean binlogs (ensure no slave is attached)
	- use this only the first time! than use PURGE BINARY LOGS instead
- RESET SLAVE - clean relay logs (ensure slave is stopped)
- SHOW SLAVE STATUS \G

SHOW MASTER STATUS;
SHOW BINARY LOGS;
SHOW BINLOG EVENTS IN 'logfile';

			SETTING UP HOT STANDBY:
- configure the standby (as a slave, but log changes):
[mysqld]
user = mysql
pid-file = /var/run/mysqld/mysqld.pid
socket = /var/run/mysqld/mysqld.sock
port = 3306
basedir = /usr
datadir = /var/lib/mysql
tmpdir = /tmp
log-bin = master-bin
log-bin-index = master-bin.index
server-id = 1
log-slave-updates

- performing a switchover:
	- stop both the slave and the standby and compare the binlog positions
		(use SHOW SLAVE STATUS\G)
	- if e.g. the standby is ahead of the slave (the Exec_Master_Log_Pos value
		is higher on the standby) make the slave catch up:
slave> START SLAVE UNTIL
	-> MASTER_LOG_FILE = 'master-bin.000096',
	-> MASTER_LOG_POS = 756648;
Query OK, 0 rows affected (0.18 sec)

slave> SELECT MASTER_POS_WAIT('master-bin.000096', 756648);
Query OK, 0 rows affected (1.12 sec)

	- find out the position the master log stopped in on the standby:
standby> SHOW MASTER STATUS\G
*************************** 1. row ***************************
File: standby-bin.000019
Position: 56447
		...

	- then redirect the slave to that position on the standby:
slave> CHANGE MASTER TO
	MASTER_HOST = 'standby-1',
	MASTER_PORT = 3306,
	MASTER_USER = 'repl_user',
	MASTER_PASSWORD = 'xyzzy',
	MASTER_LOG_FILE = 'standby-bin.000019',
	MASTER_LOG_POS = 56447;
Query OK, 0 rows affected (0.18 sec)

slave> START SLAVE;
Query OK, 0 rows affected (0.25 sec)

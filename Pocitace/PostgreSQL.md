https://postgresqlco.nf
- configuration option reference

https://www.postgresql.org/docs/10/monitoring-stats.html
- postgresql stat views

== window functions ==
http://robots.thoughtbot.com/postgres-window-functions
http://www.postgresql.org/docs/18/tutorial-window.html
http://www.postgresql.org/docs/18/functions-window.html

=== monitoring ===
https://pgmetrics.io
- command line tool that reports a lot of info about the cluster instance

https://pgdash.io/blog/monitoring-postgres-replication.html
- stat views that can be used to monitor replication

https://sysadvent.blogspot.com/2017/12/day-12-monitoring-postgres-replication.html
- monitoring replication lag

https://severalnines.com/database-blog/key-things-monitor-postgresql-analyzing-your-workload
https://www.influxdata.com/blog/metrics-to-monitor-in-your-postgresql-database/

=== backups and replication ===
https://www.opsdash.com/blog/postgresql-replication-topologies.html
https://www.opsdash.com/blog/postgresql-replication-slots.html
- general replication info

https://pgbackrest.org
https://pgstef.github.io/2018/01/04/introduction_to_pgbackrest.html
- nice backup/restore tool with support for (parallel) full/incremental backup, handles retention
  and has many other advanced features

https://clusterlabs.github.io/PAF/
https://clusterlabs.github.io/PAF/administration.html
https://clusterlabs.github.io/PAF/CentOS-7-admin-cookbook.html
- automatic master/standby failover using pacemaker

https://blog.timescale.com/blog/scalable-postgresql-high-availability-read-scalability-streaming-replication-fb95023e2af/

https://www.percona.com/blog/2019/10/31/postgresql-application-connection-failover-using-haproxy-with-xinetd/
https://www.percona.com/blog/2019/11/08/configure-haproxy-with-postgresql-using-built-in-pgsql-check/
- postgresql connection failover

https://severalnines.com/database-blog/what-look-if-your-postgresql-replication-lagging
https://info.crunchydata.com/blog/wheres-my-replica-troubleshooting-streaming-replication-synchronization-in-postgresql
- replication troubleshooting
### random stuff
#### get disk space used by tables and indices
SELECT
   relname AS table_name,
   pg_size_pretty(pg_total_relation_size(relid)) AS total,
   pg_size_pretty(pg_relation_size(relid)) AS internal,
   pg_size_pretty(pg_table_size(relid) - pg_relation_size(relid)) AS external,
   pg_size_pretty(pg_indexes_size(relid)) AS indexes
    FROM pg_catalog.pg_statio_user_tables ORDER BY pg_total_relation_size(relid) DESC;
#### get count of seq and idx reads
SELECT relname,
    seq_scan,
    seq_tup_read,
    idx_scan
FROM pg_stat_user_tables
WHERE seq_scan > 0
ORDER BY 3 DESC LIMIT 10;

\watch - run query repeatedly to watch changing results
#### get fast count(*) approximation - value from last autovacuum
SELECT reltuples::bigint
FROM pg_catalog.pg_class
WHERE relname = 'mytable';

\set ECHO_HIDDEN on - show queries run by \ commands
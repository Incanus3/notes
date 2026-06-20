### References
- https://postgresqlco.nf - searchable PostgreSQL configuration option reference.
- https://www.postgresql.org/docs/current/monitoring-stats.html - current PostgreSQL statistics and monitoring views.

### Window functions
- https://www.postgresql.org/docs/current/tutorial-window.html - official tutorial for window functions.
- https://www.postgresql.org/docs/current/functions-window.html - official reference for window functions.
- http://robots.thoughtbot.com/postgres-window-functions - Thoughtbot article introducing PostgreSQL window functions.

### Tools
- https://pgmetrics.io - command-line tool for reporting PostgreSQL cluster metrics.
- https://pgbackrest.org - backup/restore tool with full/incremental backups, parallelism, retention handling, and advanced restore support.

### Useful queries

#### Disk space used by tables and indexes
```sql
SELECT
   relname AS table_name,
   pg_size_pretty(pg_total_relation_size(relid)) AS total,
   pg_size_pretty(pg_relation_size(relid)) AS internal,
   pg_size_pretty(pg_table_size(relid) - pg_relation_size(relid)) AS external,
   pg_size_pretty(pg_indexes_size(relid)) AS indexes
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;
```

#### Count sequential and index reads
```sql
SELECT
    relname,
    seq_scan,
    seq_tup_read,
    idx_scan
FROM pg_stat_user_tables
WHERE seq_scan > 0
ORDER BY 3 DESC
LIMIT 10;
```

#### Fast approximate row count from planner statistics
```sql
SELECT reltuples::bigint
FROM pg_catalog.pg_class
WHERE relname = 'mytable';
```

### psql tips
- `\watch` - run the previous query repeatedly to watch changing results.
- `\set ECHO_HIDDEN on` - show SQL queries run by psql meta-commands.

### Cleanup note
Old PostgreSQL monitoring/replication/failover blog-link piles and environment-specific PostgreSQL 12 cluster repair commands were removed as stale.

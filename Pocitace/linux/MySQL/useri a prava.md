==== tables with user and privileges information ====
 These mysql database tables contain grant information:
    user: Contains user accounts, global privileges, and other non-privilege columns.
    db: Contains database-level privileges.
    host: Obsolete.
    tables_priv: Contains table-level privileges.
    columns_priv: Contains column-level privileges.
    procs_priv: Contains stored procedure and function privileges.
    proxies_priv: Contains proxy-user privileges. 

* tabulky
	* mysql.user - host, user, pass, glob privs (sloupec pro kazdy typ prava)
	* mysql.db - host, user, db, sloupec pro kazdy typ prava
	* mysql.host - host, db, sloupec pro kazdy typ prava
	* mysql.tables_priv - host, user, db, table_name, grantor, table priv (set of privileges), column_priv (set of privileges)
	* mysql.columns_priv - host, user, db, table_name, column_name, column_priv (set)
	* mysql.procs_priv - host, user, db, routine_name, routine_type, grantor, proc_priv (set)
	* information_schema.user_privileges - GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE - globalni prava po jednotlivych radcich
	* information_schema.schema_privileges - GRANTEE, TABLE_SCHEMA, PRIVILEGE_TYPE, IS_GRANTABLE
	* information_schema.table_privileges - user@host, table_schema (db), table_name, privilege_type, is_grantable

* show grants for - zobrazi jen nektere, tabulka s jednim sloupcem - sql grant prikaz

==== revoking all privileges ====
* revoke all privileges on *.* revokes only privileges granted on *.*, not those for specific database/table
	* solution - REVOKE ALL PRIVILEGES, GRANT OPTION FROM
* revoke all privileges on database.* revokes only privileges granted on database.* not those for specific table

* reseni - pokud show grants for zobrazuje vsechna relevantni prava, prevest na revoke, vyhodnotit
* treba
	* odstranit radky s usage
	* nahradit grant za revoke
	* odstranit cast zacinajici REQUIRE nebo WITH

* **v mysql.db jsou defaultne prava pro vsechny usery na databaze zacinajici test_ a databazi test, takze kazdy user (i nove vytvoreny), muze manipulovat s temito databazemi**

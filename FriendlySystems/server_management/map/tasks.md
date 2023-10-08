===== tasks =====

- tasks - implement low-level functionality - manipulation of mysql
  databases/users/privileges, system users/groups, filesystem, etc.

- Tasks::MySQL
  - defines modules that
    - provide utility functions
    - require the includer to implement mysql_query which returns array of
      arrays
      - this way the modules are not bound directly to Connection::MySQL
        but still expect mysql_query to raise its exceptions
  - Databases
    - get_databases - array of strings
    - get_tables_in(dbname) - array of strings
    - create_db(dbname,if_not_exists = false)
    - drop_db(dbname,if_exists = false)
    - database_exists?(dbname)
    - table_exists?(dbname,table)
    - create_table(dbname,table,columns,if_not_exists = false)
    - drop_table(dbname,table,if_exists = false)
  - Users
    - user_exists?(user,host = 'localhost')
    - get_passhash(user,host = 'localhost')
    - create_user(user,host = 'localhost',pass = nil,if_not_exists = false)
    - create_user_passhash(user,host,passhash,if_not_exists = false)
    - drop_user(user,host = 'localhost',if_exists = false)
    - set_passhash(user,host,passhash)
  - UserInfos
    - get_users(only_users = nil)             -> array of UserInfo
    - get_user(user,host = 'localhost')       -> UserInfo
    - get_user_privs(user,host = 'localhost') -> array of priv names
    - get_users_hosts                         -> array of pairs of strings
    - UserInfo - value object representing row from mysql.user table
      - attributes - host, user, passhash, privs (array of priv names)
  - Rights
    - includes Databases and Users
    - get_grants(user,host = 'localhost')
    - get_grants_on_db(user,host,db)
    - grant(privileges,db,table,user,host = 'localhost')
    - revoke(privileges,db,table,user,host = 'localhost')
    - revoke_all(user,host = 'locahost')
    - revoke_all_on_db(user,host,db)
    - change_priv_level(user,host,db,level)
      - levels: 0 - no privs, 1 - read privs, all privs
- Tasks::System
  - Users - NEEDS TEST
    - get_uid(username)
    - get_gid(groupname)
    - get_user_home(username,groupname,basedir)
    - user_exists?(username)
    - create_user(username,uid,gid,home)
    - create_group(groupname,gid,groupdir)
  - Files - NEEDS TEST
    - create_dir(path,uid,gid) - create dir with given ownership unless it exists

- Server::MySQL
  - provides cannonical includer for Tasks::MySQL submodules
  - forwards methods starting with mysql_ to stored Connection::MySQL (without
    prefix)
  - defines mysql_query as mysql_get_table
  - provides .new (opens connection), .start (yields server) and #close

- boundaries:
  - Tasks::MySQL submodules require includer to provide mysql_query and expect
    it to raise Connection::MySQL errors

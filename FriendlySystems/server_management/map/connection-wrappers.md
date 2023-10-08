===== connection-wrappers =====

- wrappers around specific connection libraries (mysql, ssh, scp) prividing
  unified and easy-to-use API

- Connection
  - abstract, defines unified interface for descendants
  - interface:
    - new(options) - saves options and calls parse_options
    - open - only if not open already
    - reopen - unconditionaly
    - open?
    - close
    - self.start(options) - creates instance, opens connection, returns the
      instance or yields it if block given
  - descendants should override:
    - parse_options(options)
    - connection - returns the underlying connection
    - really_open - open the underlying connection
    - close - close the underlying connection

- MySQL < Connection
  - wraps Mysql2::Client
  - provides:
    - query(query,options = {})          -> Mysql2::Result (provides each)
    - get_table(query,options = {})      -> array of arrays
    - get_hash_table(query,options = {}) -> array of hashes
    - get_value(query,options = {})      -> single value
  - translates Mysql2 errors
  - when open_ad_hoc: true given to new, opens the connection upon first query

- boundaries:
  - Mysql2::Client (new, query), Mysql2::Error

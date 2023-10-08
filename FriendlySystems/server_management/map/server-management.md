===== server-management =====

- Manager
  - .new(config,logger)
    - saves config and logger
    - checks config (required values)
    - initializes MessageHandler
  - #start
    - starts MessageHandler
  - .run(conf_path)
    - loads config from file
    - initializes logger from config
    - creates new instance supplying config and logger
    - starts it

- Configuration
  - provides default values
  - checks required options
  - loads config from file

- SafeLogger < Logger
  - extracts options from config
  - provides default loglevel and datetime format
  - catches errors when creating logfile

- MessageHandler
  - .new(config,logger)
  - #start
    - initializes MsgServer::Consumer with config and logger
    - subscribes for requests (see handle_request)
    - when server not responding logs error, sleeps, then retries
    - should catch all initial errors
  - handle_request (private)
    - logs receipt
    - checks message validity - required fields (action, object_type,
      parameters), correct action (create, update, delete)
      - logs error and aborts if invalid, should inform sender
    - creates manageable object
      - logs error and aborts if invalid, should inform sender
    - runs actions on it with parameters
      - logs success or failure, should inform sender
      - expects action to raise only one of three exceptions
        - CriticalError - no hope of later success
        - RecoverableError - try again later
        - Warning - log and continue, e.g. database already exists

- MessageHandler#handle_request is given to Consumer#subscribe_for_requests as
  callback
- Consumer listens for new messages in a separate thread, the main thread is
  stopped after initialization (sleeping but alive)
- if an exception leaks out of handle_request, the consumer thread dies, but the
  main thread is still alive (although sleeping), so god won't notice this and
  restart the process
-> join the listening thread from the main (in lib/server-management.rb)
-> catch all exceptions in handle_request
-> test this thoroughly

- MngObjects::Factory
  - .register(name,klass)
  - .create(type,params,config)
    - initialize instance of class registered to type with params and config
    - raise UnknownObjectType if type unknown

- MngObjects::MngObject
  - base class for all manageable objects
  - .new(param_hash,config)
    - normalizes param_hash (keys to symbols)
    - stores config
    - checks param_hash (using required_params which descendants should override)
      - raises NotEnoughData if missing params
    - calls parse_params (descendants should override)
  - virtual - create, update, delete
    - should raise only CriticalError, RecoverableError or Warning

- MngObjects::MySQLObject < MngObject
  - provides mysql connection to descendants
    - uses Connection::MySQL from connection-wrappers
    - translates its errors to CriticalError or RecoverableError
  - forwards all undefined methods starting with 'mysql_' to the connection
  - forwards mysql_query(query) to connection.get_table(query)

- MngObjects::MySQLDatabase < MySQLObject
  - required_params - :database_name
  - create or drop database, update undefined

- MngObjects::MySQLUser < MySQLObject
  - required_params - :username, :password_hash
  - list of hostnames is read from config
  - create - create user with passhash
  - delete - drop user
  - update - change passhash

- MngObjects::MySQLRight < MySQLObject
  - required_params - :username, :database_name, :level
  - list of hostnames is read from config
  - create, update - set privileges to level
  - delete - set privileges to 0

- ALL FOLLOWING NEED TESTS

- MngObjects::SystemUser
  - required_params - :username, :uid, :gid, :homedir
  - create/delete system user, update undefined

- MngObjects::SystemGroup
  - required_params - :groupname, :gid
  - optional - :groupdir
  - create - create system group and groupdir if provided
  - delete - delete system group
  - update undefined

- MngObjects::WebHosting
  - required_params - :username, :groupname, :domain
  - optional - :aliases, :webmaster
  - create
    - create system user (group should be created with account)
    - create document root (parent = groupdir should be created with account)
    - create apache config and link
  - update and delete undefined

- boundaries
  - Manager.start(conf_path) - expects YAML config file with options
    - for itself - log_logfile, log_progname, log_level, log_datetime_format
    - for consumer - hostname, group, role, msg_server_hostname, ... (see
      Consumer)
    - for manageable objects
      - mysql_host, mysql_user, mysql_pass, mysql_port, mysql_socket,
        mysql_hostnames
      - webs_path, share_path, apache_conf_path

- dependencies
  - MessageHandler uses message-server
    - MsgServer::Consumer#subscribe_for_requests, #send_response
  - manageable objects include modules from tasks
  - MySQLObject uses connection-wrappers
    - Connection::MySQL

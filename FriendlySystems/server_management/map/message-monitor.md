===== message-monitor =====

- ActiveRecordConnector
  - establishes AR connection to database
  - .ar_connect(config)
    - config - must provide [] with following options (symbols)
      - db_host, db_user, db_pass, db_database, db_adapter
      - only db_user, db_pass and db_database are required
  - .connect(options)
    - takes options for AR::Base#establish_connection directly:
      - host, username, password, database, adapter
      - username, password and database are required

- models
  - define AR models taken from fs-management
  - Message
    - attributes - id, state, name, object_type, action, parameters
    - scope recent - messages with state 'new'
    - has_many server_messages
  - Server
    - attributes - id, name, group, master
    - has_many server_messages
  - ServerMessage
    - attributes - id, state
    - belongs_to message, server

- ConfigParser
  - parse_conf_file(file) - reads file, decodes from YAML
    - file - name or object
  - parse_conf_hash(hash) - normalizes hash - converts keys to symbols

- MessageMonitor
  - .new(conf_hash)
  - #start(sleep_time = 1)
    - sets signal handlers
    - establishes AR connection
    - initializes MsgServer::Producer from config (wraps conf_hash in OpenStruct)
    - subscribes for responses (see #handle_reponse)
    - starts event loop (see #start_event_loop)
  - .start(conf_file)
    - reads config from file, creates instance, starts it
  - private:
    - start_event_loop
      - checks db for new messages, sends them using producer, sets state to 'sent'
    - handle_response(response)
      - updates server_message.state to response.state
      - when all Message's ServerMessages are 'accepted', sets message.state to
        'accepted'
      - when some ServerMessage is 'rejected', sets message.state to 'rejected'

- boundaries:
  - MessageMonitor.start(conf_file) - load config from YAML file
  - MessageMonitor.new(conf_hash).start - load config from hash
    - config - see ActiveRecordConnector.ar_connect

- dependencies:
  - active record - table structure of messages, servers and server_messages
    taken from fs-management
  - MsgServer::Producer (.new, #send_request, #subscribe_for_responses)

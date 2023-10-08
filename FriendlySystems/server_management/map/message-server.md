===== message-server =====

- wrapper around Bunny - encodes messages, maintains connection and channel to
  RabbitMQ broker, allocates exchanges and queues, sends messages and subscribes
  with specific options to ensure correct routing and reliability

- MsgServer
  - provides common message sending and subscription functionality to
    specialized Producer and Consumer classes
  - responsibilities:
    - extracts options from config (via Configuration)
    - allocates AMQP resources (via AMQPResources)
    - adds content info to messages and provides message encoding to descendants
      (via MessageEncoding)
    - sets signal traps before subscription (via SignalTraps)
      - SHOULD THIS BE HERE? - could set traps in Manager much sooner
    - logs sending and receipt of messages (via MessageLogging)
  - interface:
    - initialize(config = OpenStruct.new,logger = nil)
      - config - any object implementing readers documented in Configuration
      - logger - used for logging of initial, connection- and channel-level errors
    - send_msg(message,options,exchange_name = "",exchange_type = :direct)
      - publish the message as persistent to exchange declared by name and type,
        supplying given additional options
      - message - the message object to be sent (see MessageEncoding for details)
      - options - additional options to be supplied to AMQP::Exchange#publish
    - subscribe(queue_name,options = {},routing_keys = [],exchange_name = "",
                exchange_type = :direct)
      - declare durable exchange and queue, bind the queue to the exchange using
        routing_keys and subscribe for message reception supplying additional options
        (accepted by AMQP::Queue#subscribe) and a block
      - doesn't block the calling thread

- Consumer < MsgServer
  - provides replay_to info to received messages and routing info for sent
    responses
  - interface:
    - subscribe_for_requests(options = {}, &callback)
      - subscribes for messages delivered to msg_exchange (topic)
      - queue given by hostname
      - routing keys inferred from group and role (master/slave)
      - decodes message and sets response_queue to reply_to (set to
        response_queue by Producer)
      - hostname, group, role and msg_exchange loaded from config
    - send_response(response)
      - encodes the response and sends it to response_queue of the original message
      - checks required fields
      - encodes the response
      - uses default direct exchange (routes to queue based on routing key)
      - uses message.response_queue as routing key
      - sets sender to hostname (loaded from config)

- Producer < MsgServer
  - provides routing info for sent messages and origin info to received responses
  - interface:
    - send_request(request)
      - encodes the message and sends it to msg_exchange, specified in config,
        with routing key composed of group and run_on message attributes
      - reply_to header is set according to msg_response_queue given in config
      - checks required fields
      - encodes request
      - sends it to msg_exchange (config, topic)
      - inferrs routing key from message.group and .run_on
      - sets reply_to to msg_response_queue (config)
    - subscribe_for_responses(options = {}, &callback)
      - subscribes for messages delivered to msg_response_queue given in config
      - decodes responses

- Message
  - encapsulates Messages that MsgServer works with, provides conversions from
    and to hash, knows what fields are required
  - interface:
    - self.from_hash(hash) - creates Message instance from hash
    - self.to_hash(object) - creates hash with Message fields from object (calling
                             appropriate readers)
    - to_hash - converts Message to hash
  - fields - id
- Request < Message
  - fields - object_type, action, parameters, response_queue
- Response < Message
  - fields - state, results, sender

- Encoding
  - encode_request, encode_response - translate message object (mustn't be
    kind_of Message) to hash and encodes as JSON
  - decode_request, decode_response - translates JSON hash to Message type
    (Request or Response)
  - add_content_info(publish_options) returns options with included content_type
    and content_encoding

- Configuration
  - config given to MsgServer#initialize (or descendants) can be any object with
    the appropriate readers/methods
  - all messaging related options are prefixed by msg_
    - msg_server_hostname, msg_server_port, msg_server_vhost,
      msg_server_user, msg_server_pass
    - msg_reconnect_period (10)
    - msg_exchange ('management.actions')
    - msg_response_queue ('management.responses')
  - consumer server info:
    - hostname, group, role (master/slave)

- boundaries:
  - Producer + Consumer - initialize
    - config - see Configuration
    - logger - should behave like standard ruby logger
      - implement fatal, error, warn, info, debug
  - Producer
    - send_request(request)
      - request can be any object providing following readers:
        - group, run_on
        - Request fields
    - subscribe_for_responses(options = {}, &callback)
      - options - given to Bunny::Queue#subscribe
      - upon receipt Response object is yielded to callback
  - Consumer
    - subscribe_for_requests(options = {}, &callback)
      - options - given to Bunny::Queue#subscribe
      - upon receipt Request object is yielded to callback
    - send_response(response)
      - response can be any object providing following readers:
        - response_queue (consumer program should set this from
          request.response_queue)
        - Response fields
  - inwards:
    - Bunny.new
    - Bunny::Session#channel
    - Bunny::Exchange.new, #publish
    - Bunny::Channel#queue
    - Bunny::Queue#bind, #subscribe
    - exception classes

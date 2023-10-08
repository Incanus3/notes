Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-02-27T16:50:13+01:00

====== message-server ======
Created Wednesday 27 February 2013

===== responsibilities =====
* Producer and Consumer - specialized funcionality
	* routing options
		* producer
			* sending of messages
				* routing key - from group and run_on
				* reply_to (response queue) - **could be in payload** (once messages and responses are encoded/decoded separately)
				* exchange_name - read from config, **same for producer and consumer, but used in different places**
				* exchange_type - constant, **same for producer and consumer, but used in different places**
			* subscribing for responses
				* response_queue - read from config, same as reply_to
				* options - exclusive, acknowledgement (should this be here?)
				* sender - read from message_metadata[:sender], **should be in payload, doesn't concern routing**
		* consumer
			* subscribing for messages
				* queue_name - from hostname
				* routing_keys - from group and run on - for binding to exchange
				* exchange_name - read from config, **same for producer and consumer, but used in different places**
				* exchange_type - constant, **same for producer and consumer, but used in different places**
				* response_queue - read from message_metadata[:reply_to] - **could be in payload**
			* sending of responses
				* routing key - response_queue
				* sender - from hostname, **should be in payload, doesn't concern routing** (once messages and responses are encoded/decoded separately)
* MsgServer - common functionality
	* defaults for exchange_name, exchange_type, routing_keys, subscribe options
	* provides common publish/subscribe options (persistence, exclusivity)
	* encoding/decoding of messages - **extracted to Enconding**
	* extraction of connection options from config - **extracted to Configuration**
	* extraction of (and defaults for) message_exchange, reconnect period - **extracted to Configuration**
	* allocates resources (+ error handling) - connection, channel, queue, exchange - **extracted to AMQPResources**
	* binds queue to exchange using routing_keys - **extracted to AMQPResources**
	* logs publishing/receipt of messages - **extracted into MessageLogger**
	* sets signal traps before subscription - **extracted to SignalTraps**

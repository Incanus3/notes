------------------------------------------------------------------------------------------------------------------------
fs-management -> db -> message-monitor -> message-server -> RabbitMQ -> message-server -> server-management
  write message  |    check message db       Producer     |           |    Consumer         MessageHandler
  to database    |        Monitor          #send_request  |           | #subscribe_for      #handle_request
                 |     #send_request                      |           |    _requests               .
                 |                                        |           |              \             .
                 |  (main thread checks db periodically)  |           |               \            .
    process 1    |            process 2 + thread          |  erlang   |  process 3 + thread     action -------> tasks
                 |                            |           |           |  (main thread initia-      .              |
                 |                            v           |           |   lizes, then sleeps)      .              v
                 |        Monitor            Producer     |           |                            v         connection-
                 |   #handle_response     #subscribe_for  |           |    Consumer         MessageHandler    wrappers
check message db |   update message db      _responses    |           | #send_response      #send_response
fs-management <- db <- message-monitor <- message-server <- RabbitMQ <- message-server <- server-management
                                                          |           |
                         server 1                         |  rabbit   |              server 2
                                                          |           |
                                                          |           | actions are integration-tested here
                                                          |           |      (server-management level)
                                                          |           | - testing them on higher levels is impractical
                                                          |           |   because they run in separate processes
                                                          |           |   -> can't chatch exceptions, set message
                                                          |           |      expectations, ...
------------------------------------------------------------------------------------------------------------------------
                 |                                                                    |
                 | <----------------------------------------------------------------> |
                 |   integration testing repo should test this transfer of messages   |
                 |     from fs-management message database to                         |
                 |     MessageHandler#handle_request and the response back            |
                 |                                                                    |
------------------------------------------------------------------------------------------------------------------------

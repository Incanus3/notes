Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-06-07T22:15:17+02:00

====== RabbitMQ ======
Created Friday 07 June 2013

==== files ====
/var/lib/rabbitmq/.erlang.cookie - must be owned by rabbitmq:rabbitmq, mode 400, same on all cluster nodes
/etc/rabbitmq/rabbitmq.config:
[
	{kernel,
		[{inet_dist_listen_min, 50000},{inet_dist_listen_max, 52000}]		# random port range (internal cluster communication, must be open on firewall)
	},
	{rabbit, [
		  {tcp_listeners, [{"192.168.50.52",5672}]},					# listen on this ip and port (must be open on firewall)
		  		   {cluster_nodes, {['rabbit@lb1','rabbit@lb2'],disk}}		# cluster nodes, type may be disk or ram, at least one should be disk
				   ]}
].

==== firewall ====
$iptables -A INPUT -p tcp -i eth1 --dport 5672 -j ACCEPT #rabbitmq                               
$iptables -A INPUT -p tcp -i eth1 --dport 4369 -j ACCEPT #erlang portmapper for rabbitmq         
#random ports for internal rabbitmq cluster communication                                        
$iptables -A INPUT -p tcp -i eth1 --dport 50000:52000 -j ACCEPT

==== cluster creation ====
rabbitmqctl stop_app
rabbitmqctl join_cluster rabbit@lb1 (add --ram for ram-only node)
rabbitmqctl start_app
rabbitmqctl cluster_status

==== web UI ====
rabbitmq-plugins enable rabbitmq_management			# on node where the webserver runs, by default listens on 15627
$iptables -A INPUT -p tcp -i eth1 -s 192.168.50.2 --dport 15672 -j ACCEPT		# -||- - firewall
rabbitmq-plugins enable rabbitmq_management_agent	# on the other nodes

==== mirrored queues ====
rabbitmqctl set_policy ha-all "^ha\." '{"ha-mode":"all"}'	# all queues with name starting with "ha." will be mirrored, they must be defined as durable and the messages must be published as persistent

* queues have to be durable, messages sent as persistent, with acknowledgement

== Unsynchronised Slaves ==
A node may join a cluster at any time. Depending on the configuration of a queue, when a node joins a cluster, queues may add a slave on the new node. At this point, the new slave will be empty: it will not contain any existing contents of the queue, and currently, there is no synchronisation protocol. Such a slave will receive new messages published to the queue, and thus over time will accurately represent the tail of the mirrored-queue. As messages are drained from the mirrored-queue, the size of the head of the queue for which the new slave is missing messages, will shrink until eventually the slave's contents precisely match the master's contents. At this point, the slave can be considered fully synchronised, but it is important to note that this has occured because of actions of clients in terms of draining the pre-existing head of the queue.
Thus a newly added slave provides no additional form of redundancy or availability of the queue's contents until the contents of the queue that existed before the slave was added have been removed. As a result of this, it is preferable to bring up all nodes on which slaves will exist prior to creating mirrored queues, or even better to ensure that your use of messaging generally results in very short or empty queues that rapidly drain. 

When the entire cluster is brought down, the last node to go down must be the first node to be brought online. If this doesn't happen, the nodes will wait 30 seconds for the last disc node to come back online, and fail afterwards. If the last node to go offline cannot be brought back up, it can be removed from the cluster using the forget_cluster_node command - consult the rabbitmqctl manpage for more information.

* error codes - http://www.rabbitmq.com/amqp-0-9-1-reference.html - uplne dole

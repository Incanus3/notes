Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-02T23:20:01+01:00

====== iptables ======
Created Saturday 02 November 2013

===== chains =====
* default - INPUT, FORWARD, OUTPUT:
'''
incoming -> [ routing decision ] ---> FORWARD ---> outgoing
                 `-> INPUT -> local process -> OUTPUT -^
'''

	* can have policies (default action when no rule matches)
* user defined - can't have policies, may be jumped to using -j
* routing decision - if destination == local address -> INPUT
	* if not and forwarding not enabled in kernel / don't know how to forward -> DROP
	* otherwise -> FORWARD, if ACCEPTed, will be sent

http://iptables.org/documentation/HOWTO//packet-filtering-HOWTO-7.html#ss7.4
When a packet matches a rule whose target is a user-defined chain, the packet begins traversing the rules in that user-defined chain. If that chain doesn't decide the fate of the packet, then once traversal on that chain has finished, traversal resumes on the next rule in the current chain.

===== examples =====
# clean all iptables rules                                                                                                                                                                                       
$iptables -P INPUT ACCEPT
$iptables -P FORWARD ACCEPT
$iptables -P OUTPUT ACCEPT
$iptables -F
$iptables -X

# create chain, which block new connections, except if comming from inside
$iptables -N block
$iptables -A block -m state --state ESTABLISHED,RELATED -j ACCEPT
$iptables -A block -m state --state NEW -i ! $extif -j ACCEPT
$iptables -A block -j DROP

# jump to that chain from INPUT and FORWARD chains
$iptables -A INPUT -j block
$iptables -A FORWARD -j block

# list rules in chain with line numbers (can be used to delete, replace, insert before, ...)
iptables -L [chain] --line-numbers

===== options =====
       -P, --policy chain target
              Set the policy for the chain to the given target.  See the section TARGETS for the legal targets.  Only built-in (non-user-defined) chains can have policies, and neither built-in nor  user-
              defined chains can be policy targets.
       -F, --flush [chain]
              Flush the selected chain (all the chains in the table if none is given).  This is equivalent to deleting all the rules one by one.
       -X, --delete-chain [chain]
              Delete  the  optional user-defined chain specified.  There must be no references to the chain.  If there are, you must delete or replace the referring rules before the chain can be deleted.
              The chain must be empty, i.e. not contain any rules.  If no argument is given, it will attempt to delete every non-builtin chain in the table.
       -N, --new-chain chain
              Create a new user-defined chain by the given name.  There must be no target of that name already.
       -A, --append chain rule-specification
              Append  one or more rules to the end of the selected chain.  When the source and/or destination names resolve to more than one address, a rule will be added for each possible address combi‐
              nation.
       -I, --insert chain [rulenum] rule-specification
              Insert one or more rules in the selected chain as the given rule number.  So, if the rule number is 1, the rule or rules are inserted at the head of the chain.  This is also the default  if
              no rule number is specified.
       -R, --replace chain rulenum rule-specification
              Replace a rule in the selected chain.  If the source and/or destination names resolve to multiple addresses, the command will fail.  Rules are numbered starting at 1.
       -D, --delete chain rule-specification
       -D, --delete chain rulenum
              Delete one or more rules from the selected chain.  There are two versions of this command: the rule can be specified as a number in the chain (starting at 1 for the first rule) or a rule to
              match.
       -j, --jump target
              This  specifies  the  target of the rule; i.e., what to do if the packet matches it.  The target can be a user-defined chain (other than the one this rule is in), one of the special builtin
              targets which decide the fate of the packet immediately, or an extension (see EXTENSIONS below).  If this option is omitted in a rule (and -g is not used), then matching the rule will  have
              no effect on the packet's fate, but the counters on the rule will be incremented.

===== targets =====
* basic - ACCEPT, DROP
* chain - jump to another chain, continue if the chain rules were all examined (and none resulted in ACCEPT or DROP
* extensions - REJECT - has the same effect as `DROP', except that the sender is sent an ICMP `port unreachable' error message
* special - RETURN has the same effect of falling off the end of a chain: for a rule in a built-in chain, the policy of the chain is executed. For a rule in a user-defined chain, the traversal continues at the previous chain, just after the rule which jumped to this chain.
	* QUEUE - http://iptables.org/documentation/HOWTO//packet-filtering-HOWTO-7.html#ss7.4





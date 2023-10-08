Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-10-14T03:30:31+02:00

====== filters ======
Created Monday 14 October 2013

==== grok - parsing of events ====
http://logstash.net/docs/1.2.1/filters/grok - log filtering
https://github.com/logstash/logstash/blob/35b407ff60ce12d60a89e1bdc817612263834759/etc/agent.conf.example
https://github.com/logstash/logstash/tree/v1.2.1/patterns  - logstash built-in grok patterns, use grok patterns_dir option to add your own
http://grokdebug.herokuapp.com/ - helper for building grok patterns + built-in pattern list
http://grokdebug.herokuapp.com/patterns

* grok patterns
	* basic structure - %{SYNTAX:SEMANTIC[:type conversion - currently only int or float, otherwise string]}
	* example:
		* 55.3.244.1 GET /index.html 15824 0.043
		* %{IP:client} %{WORD:method} %{URIPATHPARAM:request} %{NUMBER:bytes} %{NUMBER:duration}
'''
input {
  file {
    path => "/var/log/http.log"
    type => "examplehttp"
  }
}
filter {
  grok {
    type => "examplehttp"
    match => [ "message", "%{IP:client} %{WORD:method} %{URIPATHPARAM:request} %{NUMBER:bytes} %{NUMBER:duration}" ]
  }
}

'''
* grok uses oniguruma regular expressions - http://www.geocities.jp/kosako3/oniguruma/doc/RE.txt
* if you miss a pattern, either use named capture - (?<field name>pattern) or create a pattern folder with any pattern definition files, each line - NAME patter
	* and provide patterns_dir to grok filter

* match fields to parse specific logs, add tags, ...
'''
filter {
  grok {
    type => "postfix"
    match => [ "message", "%{SYSLOGBASE}" ]
    add_tag => [ "postfix", "grokked" ]
  }
'''

'''
}
'''


* match for tags
'''
grok {
  tags => "qmgr"
  patterns_dir => ["/etc/logstash/patterns"]
  match => [ "message", "%{POSTFIXQMGR}" ]
}
'''


* conditionals
'''
filter {
  if [action] == "login" {
    mutate { remove => "secret" }
  }
}
'''


==== anonymize ====
* replace field by its hash - md5, sha, ...

==== checksum ====
* add a checksum from some fields, using some algorithm (md5, sha, ...)

==== cidr ====
* add network identifier field by matching some IP fields against subnet (addr + mask)

==== cipher ====
* apply cipher to some fields

==== clone ====
* create a clone of the event, with different type

==== csv ====
* parse a csv field (source) to several fields defined by columns and separator

==== date ====
* set timestamp from a field with time (in some format), using locale, match (field, formats, ...,) and timezone
* formats - http://joda-time.sourceforge.net/apidocs/org/joda/time/format/DateTimeFormat.html
	* or
    "ISO8601" - should parse any valid ISO8601 timestamp, such as 2011-04-19T03:44:01.103Z
    "UNIX" - will parse unix time in seconds since epoch
    "UNIX_MS" - will parse unix time in milliseconds since epoch
    "TAI64N" - will parse tai64n time values

==== drop ====
* drops event that gets to this filter (e.g. by conditionals), no body

==== dns ====
* resolve ip -> host or host -> ip
* action - append or replace
* nameserver, resolve (fields), reverse (fields), timeout (int)

==== environment ====
* set fields from environment variables

==== grep ====
* drop matching events
* match, negate, ignore_case
* when drop => false, only apply add/remove_field/tag to matching events

==== json ====
* extracts field containing json into actual datastructure
* target - put datastructure under this key, if not specified, added as root fields

==== json_encode ====
* encode datastructure under source key into target field in JSON

==== kv ====
* parse fields that are in 'key=val' format
* great for postfix, iptables, http query params (set field_split to &)
* default_keys, include_keys, exclude_keys, prefix, source, target, trim, field_split, value_split

==== metrics ====
* aggregate metrics as new events - count, rate (1,5,15 minutes), min, max, standard deviation, mean 

==== multiline ====
* collapse multiline messages into a single event

==== mutate ====
* general mutations of fields
* convert (to type), gsub, join (array with separator), lowercase, merge (several fields), rename, replace, split (string to array), strip (witespace), update, uppercase

==== prune ====
* prune event fields based on whitelist/blacklist of field names or values (can be regex)
* blocklist_names, blocklist_values, whitelist_names, whitelist_values, interpolate (turn up interpolation - e.g. insert value from another field by %{field})

==== range ====
* check that field is withing expected range (int) or length range (string)
ranges => [ "message", 0, 10, "tag:short",
                "message", 11, 100, "tag:medium",
                "message", 101, 1000, "tag:long",
                "message", 1001, 1e1000, "drop" ]

==== ruby ====
* execute ruby code

==== sleep ====
* usefull for rate limitation
* time, every, replay

==== split ====
* split multiline messages into separate events
* field, terminator

==== syslog_pri ====
* parses the pri field from the front of a syslog message (facility, severity)

==== translate ====
* translates field by a dictionary (given as hash or in .yml file)
* field, destination, dictionary(_path), exact, fallback, override, regex (bool)

==== urldecode ====
* decode fields that are urlencoded

==== uuid ====
* add UUID field to event

==== xml ====
* expands XML encoded field into data structure
* source, target, xpath, store_xml

Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-10-14T03:25:13+02:00

====== logstash ======
Created Monday 14 October 2013

http://www.elasticsearch.org/webinars/Introduction-to-Logstash/ -

https://gist.github.com/asenchi/3753369 - priklad parsovani mysql query logu - uzitecny pro parsovani timestampu a spojeni viceradkovych zprav

https://github.com/shadabahmed/logstasher - logovani raisu do jsonu

https://support.shotgunsoftware.com/entries/23163863-Installing-Logstash-Central-Server
* includes setup of rsyslog to forward logs - logstash agent not needed
* includes setup of logstash central node with various filter examples
https://github.com/elasticsearch/kibana/blob/master/sample/nginx.conf - template for nginx proxy for elasticsearch api (9200) with httpauth

https://gist.github.com/paulczar/4513552 - logstash performance testing and tuning - elasticsearch template, several logstash configs, including filter examples

https://support.shotgunsoftware.com/entries/23563217-Installing-Logstash-Central-Server-Kibana-Installation

https://github.com/elasticsearch/kibana/issues/84 - kibana rozsekava field podle pomlcek, lomitek, apod - problem je v elasticsearch mappingu - treba nastavit field na index: not_analyzed, jinak je tokenizovan a rozsekan

http://logstashbook.com/code/5/apache_log.conf - apache configuration of JSON CustomLog format
http://cookbook.logstash.net/recipes/rsyslog-agent/ - setting up rsyslog to send apache logs, adds tags to various log files
http://logstash.net/docs/1.2.1/configuration#conditionals - use conditionals in filters to differentiate according to tags
http://cookbook.logstash.net/recipes/syslog-pri/ - parsing of syslog messages
https://github.com/logstash/logstash/tree/v1.2.1/patterns - logstash patterns (usable in grok filters) - haproxy, syslog
http://untergeek.com/2012/10/11/using-rsyslog-to-send-pre-formatted-json-to-logstash/

===== events input =====
* use different syslog inputs for different kind of logs (define rsyslog on source machine to send them to different ports)
	* use different type for those
* use json codec for apache logs - http://logstash.net/docs/1.2.1/codecs/json

===== events output (to elasticsearch) =====
* after parsing the event in filters, use conditionals in output part and output to different elasticsearch indices
```
output {
  if [type] == "apache" {
    if [status] =~ /^5\d\d/ {
      nagios { ...  }
    } else if [status] =~ /^4\d\d/ {
      elasticsearch { ... }
    }

    statsd { increment => "apache.%{status}" }
  }
}
```

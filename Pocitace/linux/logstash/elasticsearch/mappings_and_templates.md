Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-10-14T03:29:27+02:00

====== mappings and templates ======
Created Monday 14 October 2013

http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-templates.html
* templates that will automatically applied to new indices
* may include settings and mappings

* syslog logs mapping - set by curl -XPUT 'http://localhost:9200/index/type/_mapping' -d ' (index - logstash_2013.10.12, type - logs)
* curl -XGET '192.168.50.3[[:9200/logstash-2013.10.12/logs/_mapping]]'

curl -XPUT --user jakub:Gumiyjce1 192.168.50.3:9200/logstash-2013.10.12/logs/_mapping -d '
'''
{
  "logs" : {
    "properties" : {
      "@timestamp" : {
'''
	'''
	    "index" : "not_analyzed",
	        "type" : "date",
	        "format" : "dateOptionalTime"
	      },
	      "@version" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "facility" : {
	    "index" : "not_analyzed",
	        "type" : "long"
	      },
	      "facility_label" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "host" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "logsource" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "message" : {
	        "type" : "string"
	      },
	      "path" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "pid" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "priority" : {
	    "index" : "not_analyzed",
	        "type" : "long"
	      },
	      "program" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "severity" : {
	    "index" : "not_analyzed",
	        "type" : "long"
	      },
	      "severity_label" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "timestamp" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "type" : {
	    "index" : "not_analyzed",
	        "type" : "string"
	      }
	    }
	  }
	}'
	'''
* logstash template
curl -XPUT 192.168.50.3:9200/_template/logstash_per_index -d '
'''
{
    "template" : "logstash*",
    "order" : 0,
    "settings" : {
      "index.query.default_field" : "message",
      "index.store.compress.stored" : "true",
      "index.cache.field.type" : "soft"
    },
    "mappings" : {
      "_default_" : {
'''
                            ''"properties" : {''
                                  ''"@timestamp" : {''
	'''
	        "index" : "not_analyzed",
	        "type" : "date",
	        "format" : "dateOptionalTime"
	      },
	      "@version" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "facility" : {
	        "index" : "not_analyzed",
	        "type" : "long"
	      },
	      "facility_label" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "host" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "logsource" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "message" : {
	        "type" : "string"
	      },
	      "path" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "pid" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "priority" : {
	        "index" : "not_analyzed",
	        "type" : "long"
	      },
	      "program" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "severity" : {
	        "index" : "not_analyzed",
	        "type" : "long"
	      },
	      "severity_label" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "timestamp" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      },
	      "type" : {
	        "index" : "not_analyzed",
	        "type" : "string"
	      }
	    },
	        "_all" : {
	          "enabled" : false
	        }
	      }
	    }
	  }'
	'''

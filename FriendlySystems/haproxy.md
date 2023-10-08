Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-08-28T14:52:44+02:00

====== haproxy ======
Created Wednesday 28 August 2013

==== logovani ====
http://kvz.io/blog/2010/08/11/haproxy-logging/
[root@ch01bl02 ~]# cat /etc/rsyslog.d/haproxy 
#local6.alert;local6.notice;local6.warning       /var/log/haproxy/haproxy_error.log
local6.notice                                   /var/log/haproxy/haproxy_error.log
local6.info                                     /var/log/haproxy/haproxy.log
& ~

==== stats ====
* accessible on http://mysite.net/haproxy?stats

==== cookies ====
* used so that subsequent requests go to the same server
* options
	* appsession <cookie> len <length> timeout <holdtime> [request-learn] [prefix] [mode <path-parameters|query-string>]
		* Define session stickiness on an existing application cookie.
		* See also : "cookie", "capture cookie", "balance", "stick", "stick-table", "ignore-persist", "nbproc" and "bind-process".
	* balance <algorithm> [ <arguments> ] / balance url_param <param> [check_post [<max_wait>]]
		* Define the load balancing algorithm to be used in a backend.
		* algorithm
			* roundrobin
			* source - The source IP address is hashed and divided by the total weight of the running servers to designate which server will
			              receive the request. This ensures that the same client IP address will always reach the same server as long as no
			              server goes down or up.
	* capture cookie <name> len <length>
		* Capture and log a cookie in the request and in the response.
	* cookie <name> [ rewrite | insert | prefix ] [ indirect ] [ nocache ] [ postonly ] [ preserve ] [ httponly ] [ secure ] [ domain <domain> ]* [ maxidle <idle> ] [ maxlife <life> ]
		* Enable cookie-based persistence in a backend.
		* http://cbonte.github.io/haproxy-dconv/configuration-1.4.html#4.2-cookie

* konfigurace od tth:
global
    chroot /var/lib/haproxy
    daemon
    group haproxy
    log 127.0.0.1 local6
    nbproc 1
    user haproxy
    node haproxy1

    maxconn 40960
    spread-checks 3

    #debug
    #quiet

defaults
    mode http
    balance roundrobin
    option abortonclose
    option allbackups
    option contstats
    option dontlognull
    option forceclose
    option forwardfor except 127.0.0.1
    option httpchk HEAD /.haproxy_check HTTP/1.0
    option http-server-close
    option httplog
    option log-separate-errors
    option persist
    option redispatch
    timeout client 15s
    timeout connect 4s
    timeout http-request 5s
    timeout queue 30s
    timeout server 15s
    maxconn 8192 
    retries 3
    stats enable
    stats refresh 5s
    stats auth admin:p3tr63l
    http-check disable-on-404
    log global

backend apache
    cookie SRVID insert indirect nocache
    server ch01bl04 10.0.6.4:80 weight 100 maxconn 128 maxqueue 1024 check inter 10s downinter 10s fall 3 rise 3 slowstart 1m cookie ab1
    server ch02bl04 10.0.6.20:80 weight 100 maxconn 128 maxqueue 1024 check inter 10s downinter 10s fall 3 rise 3 slowstart 1m cookie ab2

* nastaveni custom headeru pro debug - abych poznal, ktery server mi odpovedel
backend apache_mobile_varnish
    rspadd X-Haproxy-backend:\ apache_mobile_varnish
    server devhaproxy 127.0.0.1:8080 maxconn 128 maxqueue 1024

backend apache_mobile
    rspadd X-Haproxy-backend:\ apache_modile
    server dev02 192.168.9.21:80 maxconn 128 maxqueue 1024

backend apache
    rspadd X-Haproxy-backend:\ apache
    server dev01 192.168.9.37:80 maxconn 128 maxqueue 1024

backend nginx
    rspadd X-Haproxy-backend:\ nginx
    server dev01 192.168.9.37:80 maxconn 128 maxqueue 1024

frontend zive-cz
    acl PDFSTAMPER  hdr(host) pdfstamper.zive.cz

    acl REDAKCAKY path_beg /siteadmin

    acl BE_ZIVE hdr(host)       www.zive.cz
    acl BE_KLUB hdr(host)       klub.mf.cz
    acl BE_KLUB hdr(host)       klub.zive.cz

    acl BE_MAILBLAST hdr(host)  mailblast.mfonline.cz

    use_backend iis_xvm004w_rs if REDAKCAKY
    use_backend iis_xvm004w if BE_KLUB
    use_backend iis_xvm004w_rs if BE_MAILBLAST
    use_backend apache_varnish_longtimeout if PDFSTAMPER
    use_backend nginx_varnish if static_file_extensions
    default_backend apache_varnish

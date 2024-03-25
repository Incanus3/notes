multicast:
239.1.1.1 - lb1,lb2 - corosync, port 5404,5405
226.94.1.1, port 5405

vnc porty:
5900 - portal2
5901 - portal
5902 - violette
5903 - ubu - clear install
5904 - dev
5905 - mail
5906 - testing
5907 - production
5908 - test1
5909 - mysql1a
5910 - access1a
5911 - access1b
5912 - web1a
5913 - web1a-ftp, web1b (v zaloze)
5914 - lb1
5915 - lb2
5916 - mysql1-master1
5917 - mysql1-master2
5918 - mysql1-slave1-1
5919 - mysql1-slave2-1
5920 - test2 (akfrydlant)
5922 - web1b
5927 - logstash
5928 - novy

privatni sit:
.1	nix
.2	eye
.3	apps
.4	nebula
.21	dev
.22	testing
.23	production
.24	access1a
.25	access1b
.26 testovaci - ubu clear install
.27 logstash
.28	test1
.29	test2 - akfrydlant
.31	nas
.51	lb1
.52	lb2
.71	mail
.101 web1a-weby
.102 web1b
.103 mysql1a
.151 mysql1-master1
.152 mysql1-master2
.153 mysql1-slave1-1
.154 mysql1-slave2-1
.176 web1a-ftp
.201 node1
.202 node2
.203 node3
.204 node4

verejna sit:
.1 - VOLNA
.2 - dev
.3 - testing
.4 - production
.5 - access1a
.6 - access1b
.7 - lb - testy proxy webu a mysql
.8 - WinTest
.9 - VOLNA
.10 - test1
.11 - obsazena ???
.12 - obsazena ???
.13 - dynamicka (:8080 - zenoss, :9869 - sunstone, :80 - zenoss, sunstone - deli podle hostname)
.14 - VOLNA
.15 - mail
.16 - VOLNA
.17 - lb1 - puvodni (:80 - statistiky haproxy)
.18 - VOLNA
.19 - obsazena ???
.20 - violette - docasna
.21 - dynamicka (:80 - weby, :3306 - nove mysql)
.22 - dynamicka (:80 - nove weby, :3306 - stare mysql)
.23 - web1a-ftp
.24 - lb1
.25 - lb2
.26 - VOLNA - test2
.27 - violette
.28 - portal2
.29 - portal
.30 - obsazena ???

* dynamicke adresy si predavaji lb pres pacemaker

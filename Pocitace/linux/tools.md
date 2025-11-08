http://www.tecmint.com/command-line-tools-to-monitor-linux-performance/

===== sitove utility =====
nslookup, host, dig, whois
/etc/hosts, /etc/networks, /etc/nsswitch.conf
/etc/network/interfaces, /etc/resolv.conf
ifconfig, route
/etc/sysctl.conf - enable packet forwarding to make the system act as a router
ping, traceroute, tracepath, netstat, tcpdump

===== presmerovani vystupu =====
scp prints its progress bar to the terminal using control codes. It will detect if you redirect output and thus omit the progress bar.

You can get around that by tricking scp into thinking it runs in a terminal using the "script" command which is installed on most distros by default:

**script -q -c "scp server:/file /tmp/" > /tmp/test.txt**

The content of test.txt will be:

file    0%    0     0.0KB/s   --:-- ETA
file   18%   11MB  11.2MB/s   00:04 ETA
file   36%   22MB  11.2MB/s   00:03 ETA
file   54%   34MB  11.2MB/s   00:02 ETA
file   73%   45MB  11.2MB/s   00:01 ETA
file   91%   56MB  11.2MB/s   00:00 ETA
file  100%   61MB  10.2MB/s   00:06

...which is probably what you want.

I stumbled over this problem while redirecting the output of an interactive script into a log file. Not having the results in the log wasn't a problem as you can always evaluate exit codes. But I really wanted the interactive user to see the progress bar. This answer solves both problems.

Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-01T21:38:42+01:00

====== rsyslog ======
Created Friday 01 November 2013

!!! ensure that rsyslog process actually dies during configuration reload
- it oftern survives restart by initcript

!!! upgrade to rsyslog v8 is highly recommended
- http://www.rsyslog.com/ubuntu-repository/

http://www.rsyslog.com/doc/manual.html - rsyslog documentation
http://www.rsyslog.com/doc/rsyslog_conf.html - rsyslog configuration manual
http://www.rsyslog.com/doc/rsyslog_conf_filter.html - filter conditions
- see selectors for legacy directives
http://www.rsyslog.com/doc/master/configuration/actions.html - right side of the rules
- typically output to file - modifiers

* basic format - facility.severity
* facilities - auth, authpriv, cron, daemon, kern, lpr, mail, mark, news,
  security (same as auth), syslog, user, uucp and local0 through local7
* severities - debug, info, notice, warning, warn (same as warning), err, error
  (same as err), crit, alert, emerg, panic (same as emerg)
* all messages of the specified priority and higher are logged according to the
  given action

  In addition to the above mentioned names the rsyslogd(8) understands the
following extensions: An asterisk ("*'') stands for all facilities or all
priorities, depending on where it is used (before or after the period). The
keyword none stands for no priority of the given facility.
  You can specify multiple facilities with the same priority pattern in one
statement using the comma (",'') operator. You may specify as much facilities as
you want. Remember that only the facility part from such a statement is taken, a
priority part would be skipped.
  Multiple selectors may be specified for a single action using the semicolon
(";'') separator. Remember that each selector in the selector field is capable
to overwrite the preceding ones. Using this behavior you can exclude some
priorities from the pattern.
  Rsyslogd has a syntax extension to the original BSD source, that makes its use
more intuitively. You may precede every priority with an equals sign ("='') to
specify only this single priority and not any of the above. You may also (both
is valid, too) precede the priority with an exclamation mark ("!'') to ignore
all that priorities, either exact this one or this and any higher priority. If
you use both extensions than the exclamation mark must occur before the equals
sign, just use it intuitively.

http://www.rsyslog.com/doc/rsyslog_conf_actions.html
- actions - e.g. output to file, see legacy format
http://www.rsyslog.com/doc/rsyslog_conf_modules.html
- rsyslog modules documentation
http://www.rsyslog.com/doc/imfile.html
- rsyslog text file input module

http://www.rsyslog.com/doc/v5-stable/configuration/modules/imfile.html
- legacy:
$InputFileName /path/to/file
$InputFileTag tag:
$InputFileFacility facility
$InputFileSeverity
This activates the current monitor. It has no parameters. If you forget this
directive, no file monitoring will take place!
$InputRunFileMonitor

- new:
module(load="imfile" PollingInterval="5")
input(type="imfile"
      File="/home/jakub/Projects/alto/ruby/objednavky/log/development.log"
      StateFile="rails-objednavky"
      Tag="rails"
      Severity="info"
      Facility="user")

- syslog must have permissions to read the file, otherwise nothing happens (no
  errors are logged, it just doesn't work !!!) - add syslog user to file group
- the permissions may be negated by g-x on any directory in the path, here's an easy way to find out
  the recursive parent dir permissions:

jakub@incanus:/home 2.2.4 > namei -l /home/jakub/Projects/alto/ruby/objednavky/log/development.log
f: /home/jakub/Projects/alto/ruby/objednavky/log/development.log
drwxr-xr-x root  root  /
drwxr-xr-x root  root  home
drwxr-x--- jakub jakub jakub
lrwxrwxrwx jakub jakub Projects -> Dropbox/Projects
drwx------ jakub jakub   Dropbox     <---- HERE IS THE PROBLEM
drwxr-xr-x jakub jakub   Projects
drwxr-xr-x jakub jakub alto
drwxr-xr-x jakub jakub ruby
drwxr-xr-x jakub jakub objednavky
drwxr-xr-x jakub jakub log
-rw-r--r-- jakub jakub development.log

- also beware that the file is buffered - you need to add enough content for syslog to pick it up
  immediately

https://logtrust.atlassian.net/wiki/display/LD/File+monitoring+via+rsyslog
- set logrotate to set correct ownership - /etc/logrotate.d/apache2:
create 640 root syslog

*.* /var/log/allmsgs-including-informational.log   # log all to this file
:msg, contains, "informational"  ~                 # discard all messages containgin "informational"
*.* /var/log/allmsgs-but-informational.log         # log all remaining messages here

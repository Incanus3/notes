# rsyslog

## Setup / operations

- Ensure that the rsyslog process actually dies during configuration reload; it often survives restart by initscript.
- Upgrade to rsyslog v8 is highly recommended: http://www.rsyslog.com/ubuntu-repository/

## Documentation

- http://www.rsyslog.com/doc/manual.html - rsyslog documentation.
- http://www.rsyslog.com/doc/rsyslog_conf.html - rsyslog configuration manual.
- http://www.rsyslog.com/doc/rsyslog_conf_filter.html - filter conditions; see selectors for legacy directives.
- http://www.rsyslog.com/doc/master/configuration/actions.html - right side of the rules; typically output to file, modifiers.
- http://www.rsyslog.com/doc/rsyslog_conf_actions.html - actions, e.g. output to file; see legacy format.
- http://www.rsyslog.com/doc/rsyslog_conf_modules.html - rsyslog modules documentation.
- http://www.rsyslog.com/doc/imfile.html - rsyslog text file input module.
- http://www.rsyslog.com/doc/v5-stable/configuration/modules/imfile.html - legacy v5 `imfile` module documentation.
- https://logtrust.atlassian.net/wiki/display/LD/File+monitoring+via+rsyslog - third-party file monitoring via rsyslog example.

## Selector syntax

- Basic format: `facility.severity`.
- Facilities: `auth`, `authpriv`, `cron`, `daemon`, `kern`, `lpr`, `mail`, `mark`, `news`, `security` (same as `auth`), `syslog`, `user`, `uucp`, and `local0` through `local7`.
- Severities: `debug`, `info`, `notice`, `warning`, `warn` (same as `warning`), `err`, `error` (same as `err`), `crit`, `alert`, `emerg`, `panic` (same as `emerg`).
- All messages of the specified priority and higher are logged according to the given action.

In addition to the names above, `rsyslogd(8)` understands these extensions:

- An asterisk (`*`) stands for all facilities or all priorities, depending on where it is used: before or after the period.
- The keyword `none` stands for no priority of the given facility.
- Multiple facilities with the same priority pattern can be specified in one statement using the comma (`,`) operator. Only the facility part from such a statement is taken; a priority part would be skipped.
- Multiple selectors can be specified for a single action using the semicolon (`;`) separator. Each selector in the selector field can overwrite the preceding ones, so this can exclude some priorities from the pattern.
- Rsyslog has a syntax extension to the original BSD source: precede a priority with an equals sign (`=`) to specify only this single priority and not any higher priorities.
- Precede a priority with an exclamation mark (`!`) to ignore either exactly this priority or this and any higher priority. If both extensions are used, the exclamation mark must occur before the equals sign.

## File monitoring with `imfile`

### Legacy format

```config
$InputFileName /path/to/file
$InputFileTag tag:
$InputFileFacility facility
$InputFileSeverity
```

This activates the current monitor. It has no parameters. If you forget this directive, no file monitoring will take place:

```config
$InputRunFileMonitor
```

### New format

```config
module(load="imfile" PollingInterval="5")
input(type="imfile"
      File="/home/jakub/Projects/alto/ruby/objednavky/log/development.log"
      StateFile="rails-objednavky"
      Tag="rails"
      Severity="info"
      Facility="user")
```

## Troubleshooting file monitoring

- The `syslog` user must have permissions to read the file, otherwise nothing happens. No errors are logged; it just does not work. Add the `syslog` user to the file group.
- Permissions can be negated by missing group execute (`g-x`) on any directory in the path. Use `namei -l` to inspect recursive parent directory permissions:

```console
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
```

- Beware that the file is buffered; add enough content for syslog to pick it up immediately.
- Set logrotate to set correct ownership, e.g. `/etc/logrotate.d/apache2`:

```config
create 640 root syslog
```

## Filtering examples

```config
*.* /var/log/allmsgs-including-informational.log   # log all to this file
:msg, contains, "informational"  ~                 # discard all messages containing "informational"
*.* /var/log/allmsgs-but-informational.log         # log all remaining messages here
```

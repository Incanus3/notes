Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2012-09-14T12:40:38+02:00

====== config templates ======
Created Friday 14 September 2012

=== # /etc/proftpd/proftpd.conf ===
#
# /etc/proftpd/proftpd.conf -- This is a basic ProFTPD configuration file.
# To really apply changes, reload proftpd after modifications, if
# it runs in daemon mode. It is not required in inetd/xinetd mode.
# 

# Includes DSO modules
Include /etc/proftpd/modules.conf

# Set off to disable IPv6 support which is annoying on IPv4 only boxes.
UseIPv6				off # CHANGED
# If set on you can experience a longer connection delay in many cases.
IdentLookups			off

ServerName			"FriendlySystems ftp access"
ServerType			standalone
ServerIdent			off # CHANGED
DeferWelcome			off

MultilineRFC2228		on
DefaultServer			on
ShowSymlinks			off # CHANGED

TimeoutNoTransfer		600
TimeoutStalled			600
TimeoutIdle			1200

DisplayLogin                    welcome.msg
DisplayChdir               	.message true
ListOptions                	"-lFh" # CHANGED

DenyFilter			\*.*/

# Use this to jail all users in their homes 
DefaultRoot			~ # CHANGED

# Users require a valid shell listed in /etc/shells to login.
# Use this directive to release that constrain.
RequireValidShell		off # CHANGED
RootLogin			off # CHANGED

# Port 21 is the standard FTP port.
Port				21

# In some cases you have to specify passive ports range to by-pass
# firewall limitations. Ephemeral ports can be used for that, but
# feel free to use a more narrow range.
PassivePorts                 	40000 44000 # CHANGED

# If your host was NATted, this option is useful in order to
# allow passive tranfers to work. You have to use your public
# address and opening the passive ports used on your firewall as well.
# MasqueradeAddress		1.2.3.4

# This is useful for masquerading address with dynamic IPs:
# refresh any configured MasqueradeAddress directives every 8 hours
<IfModule mod_dynmasq.c>
# DynMasqRefresh 28800
</IfModule>

# To prevent DoS attacks, set the maximum number of child processes
# to 30.  If you need to allow more than 30 concurrent connections
# at once, simply increase this value.  Note that this ONLY works
# in standalone mode, in inetd mode you should use an inetd server
# that allows you to limit maximum number of processes per service
# (such as xinetd)
MaxInstances			30

# Set the user and group that the server normally runs at.
User				proftpd
Group				nogroup

# Umask 022 is a good standard umask to prevent new files and dirs
# (second parm) from being group and world writable.
Umask				022  022
# Normally, we want files to be overwriteable.
AllowOverwrite			on

### Povolit klientum znovu navazat na stahovani
AllowRetrieveRestart            on # CHANGED

### Povolit klientum znovu navazat na upload
AllowStoreRestart               on # CHANGED

### Povolit .ftpaccess soubory (trochu zpomaluje vypis slozky)
AllowOverride                   on # CHANGED

### Zamaskovat skutecne jmeno uzivatele souboru/adresare
DirFakeUser                     on pepa # CHANGED

### Zamaskovat skutecne jmeno skupiny souboru/adresare
DirFakeGroup                    on pepagroup # CHANGED

### Zamaskuje nastaveni prav na souboru
DirFakeMode                     0000 # CHANGED

### Pokud adresar uzivatele neexistuje, tak ho vytvori s pravy 755
CreateHome 			on 755 dirmode 755 # CHANGED

### Maximalni cas procesoru v sekundach na proces
#RLimitCPU 600 600
### Maximum pameti pouzitou na proces (v bajtech)
#RLimitMemory 64M 64M
### Maximalni pocet otevrenych souboru na proces
#RLimitOpenFiles 1024 1024

# Uncomment this if you are using NIS or LDAP via NSS to retrieve passwords:
# PersistentPasswd		off

# This is required to use both PAM-based authentication and local passwords
# AuthOrder			mod_auth_pam.c* mod_auth_unix.c
AuthOrder			mod_sql.c # CHANGED

# Be warned: use of this directive impacts CPU average load!
# Uncomment this if you like to see progress and transfer rate with ftpwho
# in downloads. That is not needed for uploads rates.
#
# UseSendFile			off

TransferLog /var/log/proftpd/xferlog
SystemLog   /var/log/proftpd/proftpd.log
SQLLogFile /var/log/proftpd/sqllog.log

LogFormat default "%h %l %u %t \"%r\" %s %b" # CHANGED
LogFormat auth "%v [%P] %h %t \"%r\" %s" # CHANGED
LogFormat write "%h %l %u %t \"%r\" %s %b" # CHANGED

### Zaznamenavat pristupy k souborum a adresarum
ExtendedLog /var/log/proftpd/proftpd.access_log WRITE,READ write # CHANGED

### Zapsat vsechna prihlaseni
ExtendedLog /var/log/proftpd/proftpd.auth_log AUTH auth # CHANGED

### Povolit logovani pomoci symlinku
AllowLogSymlinks off # CHANGED

### Paranoidni uroven zaznamu
# ExtendedLog /var/log/proftpd/proftpd.paranoid_log ALL default

# Logging onto /var/log/lastlog is enabled but set to off by default
#UseLastlog on

# In order to keep log file dates consistent after chroot, use timezone info
# from /etc/localtime.  If this is not set, and proftpd is configured to
# chroot (e.g. DefaultRoot or <Anonymous>), it will use the non-daylight
# savings timezone regardless of whether DST is in effect.
#SetEnv TZ :/etc/localtime

<IfModule mod_quotatab.c>
QuotaEngine off
</IfModule>

<IfModule mod_ratio.c>
Ratios off
</IfModule>

# Delay engine reduces impact of the so-called Timing Attack described in
# http://www.securityfocus.com/bid/11430/discuss
# It is on by default. 
<IfModule mod_delay.c>
DelayEngine on
</IfModule>

<IfModule mod_ctrls.c>
ControlsEngine        off
ControlsMaxClients    2
ControlsLog           /var/log/proftpd/controls.log
ControlsInterval      5
ControlsSocket        /var/run/proftpd/proftpd.sock
</IfModule>

<IfModule mod_ctrls_admin.c>
AdminControlsEngine on # CHANGED
</IfModule>

#
# Alternative authentication frameworks
#
#Include /etc/proftpd/ldap.conf
Include /etc/proftpd/sql.conf # CHANGED

=== # /etc/proftpd/sql.conf ===
#
# Proftpd sample configuration for SQL-based authentication.
#
# (This is not to be used if you prefer a PAM-based SQL authentication)
#

<IfModule mod_sql.c>
#
# Choose a SQL backend among MySQL or PostgreSQL.
# Both modules are loaded in default configuration, so you have to specify the backend 
# or comment out the unused module in /etc/proftpd/modules.conf.
# Use 'mysql' or 'postgres' as possible values.
#
SQLBackend	mysql # CHANGED
#
SQLEngine 	on # CHANGED
#SQLAuthenticate on
#
# Use both a crypted or plaintext password 
SQLAuthTypes Backend Crypt Plaintext # CHANGED
#
# Use a backend-crypted or a crypted password
#SQLAuthTypes Backend Crypt 
#
# Connection 
#SQLConnectInfo dbname@host			user	pass
SQLConnectInfo web1ftp@mysql1.friendlysystems.cz web1ftp 1kT2zrX5 # CHANGED
#SQLUserInfo	users_tab usr_col pass_col uid_col gid_col homedir_col shell_col
SQLUserInfo     ftp_users user    password uid     gid     dir         NULL # CHANGED
#SQLGroupInfo	groups_tab grname_col gid_col members_col
SQLGroupInfo    ftp_groups groupname  gid     user
SQLMinID        5000 # CHANGED

#
# Describes both users/groups tables
#
#SQLUserInfo users userid passwd uid gid homedir shell
#SQLGroupInfo groups groupname gid members
#
</IfModule>

### Vytvorit automaticky adresar uzivatele – zastarale, v dalsi verzi nebude fungovat
#SQLHomedirOnDemand on

SQLLog PASS updatecount
SQLNamedQuery updatecount UPDATE "count=count+1, accessed=now() WHERE userid='%u'" proftpd_user
SQLLog  STOR,DELE modified
SQLNamedQuery modified UPDATE "modified=now() WHERE userid='%u'" proftpd_user

### Uzivatelske quoty:
#=======================
QuotaEngine on
QuotaLog /var/log/proftpd/quota.log
QuotaDirectoryTally on
QuotaDisplayUnits Mb
QuotaShowQuotas on

SQLNamedQuery get-quota-limit SELECT "name, quota_type, per_session, limit_type, bytes_in_avail, bytes_out_avail, bytes_xfer_avail, files_in_avail, files_out_avail, files_xfer_avail FROM proftpd_quota WHERE name = '%{0}' AND quota_type = '%{1}'"

SQLNamedQuery get-quota-tally SELECT "name, quota_type, bytes_in_used, bytes_out_used, bytes_xfer_used, files_in_used, files_out_used, files_xfer_used FROM proftpd_quota_allies WHERE name = '%{0}' AND quota_type = '%{1}'"

SQLNamedQuery update-quota-tally UPDATE "bytes_in_used = bytes_in_used + %{0}, bytes_out_used = bytes_out_used + %{1}, bytes_xfer_used = bytes_xfer_used + %{2}, files_in_used = files_in_used + %{3}, files_out_used = files_out_used + %{4}, files_xfer_used = files_xfer_used + %{5} WHERE name = '%{6}' AND quota_type = '%{7}'" proftpd_quota_allies

SQLNamedQuery insert-quota-tally INSERT "%{0}, %{1}, %{2}, %{3}, %{4}, %{5}, %{6}, %{7}" proftpd_quota_allies

QuotaLimitTable sql:/get-quota-limit
QuotaTallyTable sql:/get-quota-tally/update-quota-tally/insert-quota-tally

SQLNamedQuery gettally  SELECT "ROUND((bytes_in_used/1048576),2) FROM proftpd_quota_allies WHERE name='%u'"
SQLNamedQuery getlimit  SELECT "ROUND((bytes_in_avail/1048576),2) FROM proftpd_quota WHERE name='%u'"
SQLNamedQuery getfree   SELECT "ROUND(((proftpd_quota.bytes_in_avail-proftpd_quota_allies.bytes_in_used)/1048576),2) FROM proftpd_quota,proftpd_quota_allies WHERE proftpd_quota.name = '%u' AND proftpd_quota_allies.name = '%u'"

SQLShowInfo   LIST    "226" "Vyuzito %{gettally}MiB z %{getlimit}MiB. Jeste vam zbyva %{getfree}MiB volneho mista."

=== # /etc/proftpd/modules.conf ===
#
# This file is used to manage DSO modules and features.
#

# This is the directory where DSO modules reside

ModulePath /usr/lib/proftpd

# Allow only user root to load and unload modules, but allow everyone
# to see which modules have been loaded

ModuleControlsACLs insmod,rmmod allow user root
ModuleControlsACLs lsmod allow user *

LoadModule mod_ctrls_admin.c
#LoadModule mod_tls.c # CHANGED

# Install one of proftpd-mod-mysql, proftpd-mod-pgsql or any other
# SQL backend engine to use this module and the required backend.
# This module must be mandatory loaded before anyone of
# the existent SQL backeds.
LoadModule mod_sql.c # CHANGED

# Install proftpd-mod-ldap to use this
#LoadModule mod_ldap.c

#
# 'SQLBackend mysql' or 'SQLBackend postgres' (or any other valid backend) directives 
# are required to have SQL authorization working. You can also comment out the
# unused module here, in alternative.
#

# Install proftpd-mod-mysql and decomment the previous
# mod_sql.c module to use this.
LoadModule mod_sql_mysql.c # CHANGED

# Install proftpd-mod-pgsql and decomment the previous 
# mod_sql.c module to use this.
#LoadModule mod_sql_postgres.c

# Install proftpd-mod-sqlite and decomment the previous
# mod_sql.c module to use this
#LoadModule mod_sql_sqlite.c

# Install proftpd-mod-odbc and decomment the previous
# mod_sql.c module to use this
#LoadModule mod_sql_odbc.c

# Install one of the previous SQL backends and decomment 
# the previous mod_sql.c module to use this
#LoadModule mod_sql_passwd.c

LoadModule mod_radius.c
LoadModule mod_quotatab.c
LoadModule mod_quotatab_file.c

# Install proftpd-mod-ldap to use this
#LoadModule mod_quotatab_ldap.c

# Install one of the previous SQL backends and decomment 
# the previous mod_sql.c module to use this
#LoadModule mod_quotatab_sql.c
LoadModule mod_quotatab_radius.c
LoadModule mod_wrap.c
LoadModule mod_rewrite.c
LoadModule mod_load.c
LoadModule mod_ban.c
LoadModule mod_wrap2.c
LoadModule mod_wrap2_file.c
# Install one of the previous SQL backends and decomment 
# the previous mod_sql.c module to use this
#LoadModule mod_wrap2_sql.c
LoadModule mod_dynmasq.c
LoadModule mod_exec.c
LoadModule mod_shaper.c
LoadModule mod_ratio.c
LoadModule mod_site_misc.c

#LoadModule mod_sftp.c # CHANGED
#LoadModule mod_sftp_pam.c # CHANGED
# Install one of the previous SQL backends and decomment 
# the previous mod_sql.c module to use this
#LoadModule mod_sftp_sql.c

LoadModule mod_facl.c
LoadModule mod_unique_id.c
LoadModule mod_copy.c
LoadModule mod_deflate.c
LoadModule mod_ifversion.c
#LoadModule mod_tls_memcache.c

# keep this module the last one
LoadModule mod_ifsession.c

=== # /etc/proftpd/tls.conf ===
#
# Ukazkovy konfiguracni soubor ProFTPD pro FTPS spojeni.
#
# Pozor, FTPS zavadi nekolik omezeni pri traverzi NAT.
# Pro vice informaci se podivejte na:
# http://www.castaglia.org/proftpd/doc/contrib/ProFTPD-mini-HOWTO-TLS.html
#

<IfModule mod_tls.c>

### Povolit ProFTPD TLS/SSL
TLSEngine                               on

### Soubor s logem pro vse ohledne TLS spojeni
TLSLog                                  /var/log/proftpd/tls.log

### Typ protokolu – TLSv1, SSLv3, SSLv23 (kompatibilita obou predchozich):
TLSProtocol                             SSLv3 TLSv1

#
# Pokud chcete vygenerovat self-signed certifikat, pouzijte tento prikaz:
#
# openssl req -x509 -newkey rsa:1024 \
#          -keyout /etc/proftpd/ssl/proftpd.key.pem \
#          -out /etc/proftpd/ssl/proftpd.cert.pem \
#          -nodes -days 365
#
# Soubor proftpd.key.pem musi byt citelny pouze pro uzivatele root. Ostatni soubory mohou
# byt citelne pro kohokoli.
#
# chmod 0600 /etc/proftpd/ssl/proftpd.key.pem
# chmod 0640 /etc/proftpd/ssl/proftpd.cert.pem
#

### Cesty k certifikatum:
TLSRSACertificateFile                   /etc/proftpd/ssl/proftpd.cert.pem
TLSRSACertificateKeyFile                /etc/proftpd/ssl/proftpd.key.pem

### Soubor s certifikatem certifikacni autority (CA) pro overovani klientu:
#TLSCACertificateFile                    /etc/ssl/certs/CA.pem
# cesta k crtifikatum pro overovani klientu pomoci CA:
#TLSCACertificatePath                    /etc/ssl/certs/
# cesta ke zrusenemu/neduveryhodnemu certifikatu:
#TLSCARevocationFile                     /etc/ssl/revocate/CA.pem
# cesta ke zrusenym/neduveryhodnym certifikatum:
#TLSCARevocationPath

### Neoverovat klientuv certifikat
TLSOptions                              NoCertRequest

### Nedotazovat se na klientuv certifikat
TLSVerifyClient                         off

### Vyzadovat TLS spojeni; pokud je off, klient se bude moci pripojit i nesifrovane
TLSRequired                             off

### Spojeni se navaze s trvalym certifikatem a dalsi komunikace a prenos dat
# probiha s docasnym. Da se nastavit platnost docasneho v navaznosti na
# casU prenosu, objemu prenesenych dat atd.
# Tuto fci rozhodne moc klientu nepodporuje, takze se asi ani moc nepouziva.

# Nastavit tak, aby nebylo nutne, ale jen pozadovane/dobrovolne:
#TLSRenegotiate required off
# Po 1 hodine:
#TLSRenegotiate ctrl 3600
# Po preneseni 500 MiB dat:
#TLSRenegotiate data 512000
# Timeout:
#TLSRenegotiate timeout 300
# Veskere nastaveni v jedne directive:
#TLSRenegotiate ctrl 3600 data 512000 required off timeout 300

</IfModule>

Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-05T20:59:37+01:00

====== contents ======
Created Tuesday 05 November 2013

**# dpkg -L amanda-server**
/usr/sbin/amstatus
/usr/sbin/amgetconf
/usr/sbin/amflush
/usr/sbin/activate-devpay
/usr/sbin/amtape
/usr/sbin/amcleanup
/usr/sbin/amadmin
/usr/sbin/amcheckdump
/usr/sbin/amreport
/usr/sbin/amcheck
/usr/sbin/amrmtape
/usr/sbin/amtoc
/usr/sbin/amcheckdb
/usr/sbin/amdump
/usr/sbin/amoverview
/usr/sbin/amplot
/usr/sbin/amlabel
/usr/sbin/amtapetype
/usr/share/doc/amanda-server/examples/amanda.conf.gz
**/usr/share/doc/amanda-server/examples/dumptypes.gz - predefined dumptypes and list of options**
/usr/share/doc/amanda-server/examples/tapetypes.gz
/usr/share/doc/amanda-server/examples/advanced.conf.gz
/usr/share/doc/amanda-server/examples/amanda-S3.conf
/usr/share/doc/amanda-server/examples/amanda-tape-changer.conf
/usr/share/doc/amanda-server/examples/amanda-single-tape.conf
**/usr/share/doc/amanda-server/examples/amanda-harddisk.conf**
/usr/share/doc/amanda-server/examples/chg-manual.conf
/usr/share/doc/amanda-server/examples/README
/usr/share/doc/amanda-server/examples/xinetd.amandaserver
/usr/share/doc/amanda-server/examples/inetd.conf.amandaserver
**/usr/share/doc/amanda-server/examples/disklist** - rows - host path dumptype
/usr/share/doc/amanda-server/examples/chg-scsi.conf
/usr/share/doc/amanda-server/examples/chg-multi.conf
**/usr/share/doc/amanda-server/examples/crontab.amanda**
/usr/share/man/man1/activate-devpay.1.gz
**/usr/share/man/man8/amreport.8.gz**
/usr/share/man/man8/amgetconf.8.gz
/usr/share/man/man8/amtoc.8.gz
/usr/share/man/man8/amcheckdump.8.gz
**/usr/share/man/man8/amdump.8.gz**
/usr/share/man/man8/amplot.8.gz
/usr/share/man/man8/amcleanup.8.gz
/usr/share/man/man8/amcheckdb.8.gz
/usr/share/man/man8/amlabel.8.gz
**/usr/share/man/man8/amanda.8.gz**
/usr/share/man/man8/amrmtape.8.gz
**/usr/share/man/man8/amadmin.8.gz**
**/usr/share/man/man8/amoverview.8.gz**
/usr/share/man/man8/amtape.8.gz
/usr/share/man/man8/amflush.8.gz
/usr/share/man/man8/amtapetype.8.gz
**/usr/share/man/man8/amstatus.8.gz**
**/usr/share/man/man8/amcheck.8.gz**

**# dpkg -L amanda-common**
**/usr/sbin/amserverconfig**
* amserverconfig test --template harddisk --mailto jakub
/usr/sbin/amdevcheck
/usr/sbin/amcrypt-ossl
/usr/sbin/amservice
/usr/sbin/amcryptsimple
/usr/sbin/amvault
**/usr/sbin/amaddclient**
/usr/sbin/amcrypt-ossl-asym
/usr/sbin/amdump_client
/usr/sbin/amarchiver
/usr/sbin/amgpgcrypt
/usr/sbin/amcrypt
/usr/sbin/amaespipe
**/usr/share/man/man5/disklist.5.gz**
/usr/share/man/man5/amanda-archive-format.5.gz
/usr/share/man/man5/tapelist.5.gz
**/usr/share/man/man5/amanda.conf.5.gz**
**/usr/share/man/man7/amanda-devices.7.gz**
* see section VFS Device
/usr/share/man/man7/amanda-scripts.7.gz
**/usr/share/man/man7/amanda-auth.7.gz** - how the server talks to the client - bsd, bsdudp, bsdtcp, krb5, local, rsh, and ssh
* see sections
	* BSD, BSDUDP, AND BSDTCP COMMUNICATION AND AUTHENTICATION
	* USING INETD/XINETD SERVER
	* PORT USAGE
SSH COMMUNICATION AND AUTHENTICATION
/usr/share/man/man7/amanda-interactivity.7.gz
/usr/share/man/man7/amanda-compatibility.7.gz
**/usr/share/man/man7/amanda-changers.7.gz**
* see SPECIFYING CHANGERS, CHANGE DRIVERS -> chg-disk:VTAPEROOT (new)
**/usr/share/man/man7/amanda-match.7.gz**
**/usr/share/man/man7/amanda-taperscan.7.gz**
/usr/share/man/man8/ampgsql.8.gz
/usr/share/man/man8/amservice.8.gz
/usr/share/man/man8/amzfs-snapshot.8.gz
/usr/share/man/man8/script-email.8.gz
/usr/share/man/man8/amsamba.8.gz
/usr/share/man/man8/amaespipe.8.gz
/usr/share/man/man8/amraw.8.gz
/usr/share/man/man8/amcrypt-ossl-asym.8.gz
/usr/share/man/man8/amserverconfig.8.gz
/usr/share/man/man8/amsuntar.8.gz
/usr/share/man/man8/amgtar.8.gz
/usr/share/man/man8/amcrypt.8.gz
/usr/share/man/man8/amzfs-sendrecv.8.gz
/usr/share/man/man8/amarchiver.8.gz
/usr/share/man/man8/amstar.8.gz
/usr/share/man/man8/amcrypt-ossl.8.gz
/usr/share/man/man8/amdump_client.8.gz
/usr/share/man/man8/amaddclient.8.gz
/usr/share/man/man8/amdevcheck.8.gz
/usr/share/man/man8/amcryptsimple.8.gz
/usr/share/man/man8/amvault.8.gz
/usr/share/man/man8/amgpgcrypt.8.gz

**# dpkg -L amanda-client**
/usr/sbin/amrestore
/usr/sbin/amrecover
/usr/sbin/amoldrecover
/usr/sbin/amfetchdump
**/usr/share/man/man7/amanda-applications.7.gz**
**/usr/share/man/man5/amanda-client.conf.5.gz**
**/usr/share/man/man8/amrestore.8.gz**
**/usr/share/man/man8/amrecover.8.gz**
**/usr/share/man/man8/amfetchdump.8.gz**
**/usr/share/man/man8/amoldrecover.8.gz**
/usr/share/doc/amanda-client/examples/xinetd.amandaclient
/usr/share/doc/amanda-client/examples/inetd.conf.amandaclient
/usr/share/doc/amanda-client/examples/amanda-client-postgresql.conf
**/usr/share/doc/amanda-client/examples/amanda-client.conf**

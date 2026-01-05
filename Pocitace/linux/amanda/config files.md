===== amanda.conf =====
org "weekly"            # your organization name for reports                                
dumpuser "backup"       # the user to run dumps under                                       
mailto "jakub.kalab@friendlysystems.cz"         # space separated list of operators at your\
 site                                                                                       
dumpcycle 1 week        # the number of days in the normal dump cycle                       
runspercycle 5          # the number of amdump runs in dumpcycle days                       
tapecycle 10 tapes      # the number of tapes in rotation                                   
runtapes 1              # number of tapes to be used in a single run of amdump              
tpchanger "vtapes"      # what tape changer to use                                          
tapetype harddisk       # what kind of tape it is                                           
labelstr "weekly"       # label constraint regex: all tapes must match                      
dtimeout 1800           # number of idle seconds before a dump is aborted                   
ctimeout 30             # max number of secconds amcheck waits for each client              
etimeout 900            # number of seconds per filesystem for estimates                    

define dumptype global {
    comment "Global definitions"
    auth "ssh"
    ssh_keys "/var/backups/.ssh/id_rsa"
}

define dumptype tar-gzip {
    comment "tar dump with client-side gzip compression"
    global
    program "GNUTAR"
    index
    compress client fast
}

define dumptype tar-gzip-fast-estimate {
    tar-gzip
    estimate calcsize
}

define changer vtapes {
    tpchanger "chg-disk:/mnt/backup/vtapes/weekly"
    property "num-slot" "10"
    property "auto-create-slot" "yes"
}

define tapetype harddisk {
    comment "Virtual Tapes"
    length 50000 mbytes
}

includefile "advanced.conf"

===== advanced.conf =====
* change:
logdir   "/var/log/amanda/weekly"          # log directory                                  
indexdir "/mnt/backup/index/weekly"        # index directory                                
infofile "/mnt/backup/info/weekly"      # database DIRECTORY  

===== disklist =====
dev   /home/git/repositories tar-gzip-fast-estimate
web1a /var/www               tar-gzip-fast-estimate

===== client =====
           pre-host-estimate
               Execute before the estimate command for all dle for the client.


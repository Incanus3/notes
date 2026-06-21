# Amanda

Historical Amanda backup notes. Amanda still appears to exist, but treat this as old runbook material:

- Official site lists Amanda 3.5.3 as the latest stable release, released 03/2023.
- GitHub repo `zmanda/amanda` is not archived, but the last code push checked was 01/2024.
- These notes mostly refer to Amanda 3.3.x / old Ubuntu packaging; verify against current docs before reuse.

## Current / useful references

- https://www.amanda.org/ - Amanda Network Backup official site.
- https://github.com/zmanda/amanda (last update 01/2024) - Amanda Network Backup source repository.
- http://wiki.zmanda.com/index.php/How_Tos - Amanda how-to index.
- http://wiki.zmanda.com/man/3.3.0/amanda.8.html - Amanda 3.3.0 manual page.
- http://wiki.zmanda.com/index.php/Troubleshooting - Amanda troubleshooting notes.
- http://wiki.zmanda.com/index.php/GSWA/Build_a_Basic_Configuration - guide for building a basic Amanda configuration.
- http://wiki.zmanda.com/index.php/How_To:Set_Up_Virtual_Tapes - guide to setting up virtual tapes.
- http://wiki.zmanda.com/index.php/FAQ:Should_I_use_a_holdingdisk_when_the_final_destination_of_the_backup_is_a_virtual_tape%3F - FAQ about using a holding disk with virtual tapes.
- http://wiki.zmanda.com/index.php/How_To:Set_up_transport_encryption_with_SSH - guide to SSH transport encryption.
- http://wiki.zmanda.com/index.php/How_To:Recover_Data - guide to recovering data.

## Installation / configuration notes

Old Ubuntu package caveat:

- http://ubuntuforums.org/archive/index.php/t-1525491.html - old thread about bugs in the Ubuntu Amanda package.

Old setup notes:

```sh
chown -R backup:backup /etc/amanda /var/amanda /var/lib/amanda
su backup
```

- Copy templates from the Debian package version from `/usr/share/doc/amanda-server/examples` to `/var/lib/amanda/template.d` and `/etc/amanda/template.d`; unpack `.gz` files.
- Edit paths at the bottom of `/usr/lib/amanda/perl/Amanda/Paths.pm`:

```perl
#$amdatadir = "/usr/share/amanda";
$amdatadir = "/var/lib/amanda";
#$localstatedir = "/var/lib";
$localstatedir = "/var";
```

Virtual tape setup / smoke test:

```sh
mkdir -p /var/lib/amanda/vtapes/test
amserverconfig test --template harddisk --mailto jakub --tapedev '/var/lib/amanda/vtapes/test'
cd /usr/lib/amanda
chmod u+s calcsize dumper killpgrp planner rundump runtar
amcheck test
amdump test
amreport test      # report of the last dump
amoverview test    # counts and types of dumps on each host, disk, and date
```

SSH transport gotcha:

- The host entry in `disklist` must match the first hostname in `/etc/hosts` exactly.
- Example that does **not** work:

```text
# disklist
dev <dir> <dumptype>

# /etc/hosts
<ip> dev.domain.foo dev
```

## Client setup

```sh
chown -R amandabackup:disk /var/amanda/
su amandabackup
touch /var/amanda/amandates
```

## Recovery

Relevant old bugs:

- https://bugs.launchpad.net/ubuntu/+source/amanda/+bug/1074574 - old Ubuntu Amanda recovery bug.
- https://bugs.launchpad.net/ubuntu/+source/amanda/+bug/1077105 - old Ubuntu fix/workaround for `amidxtaped` issue.

Amanda 3.3.0 bug note:

- `amrecover` may fail with: `can't talk to tape server: service amidxtaped`.
- Fix according to the Launchpad bug above.

`amrecover(8)` restores particular files or directories and is the most automated recovery flow. It is interactive and runs on the client or server as root.

One-time permission setup:

```sh
echo "localhost root amindexd amidxtaped" >> /var/backups/.amandahosts
```

Recovery flow:

```sh
cat /etc/amanda/weekly/disklist   # print backed-up hosts and directories
mkdir /tmp/amanda-recovery
cd /tmp/amanda-recovery
amrecover weekly                  # or the required Amanda configuration name
```

Inside `amrecover`:

```text
help
sethost web1a                     # or the host to recover
setdisk /var/www                  # or the disk/path to recover
ls
cd ...
history                           # find the target date descriptor, e.g. 2013-11-04-19-36-11
setdate 2013-11-04-19-36-11
add <file>                        # or: addx <file>, delete <file>, deletex <file>, clear
extract
<enter>
<enter>
quit
```

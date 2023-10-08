Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-06-11T04:30:41+02:00

====== linux ======
Created Tuesday 11 June 2013

http://www.ansibleworks.com/ - automate server administration

http://www.root.cz/clanky/fail2ban-konec-hadani-hesel-na-serveru/#utm_source=rss&utm_medium=text&utm_campaign=rss

# PORTS TO PROCESSES:
for line in `netstat -lnp 2>&1 | awk '{if (match($0,"UNIX")) exit; print}' | tail -n +3 | cut -c 1-5,21-38,80-120 | egrep ':digit:+\.:digit:+\.:digit:+\.:digit:+::digit:+'`
do echo 

GET SERVER NAMES:
grep 192 /etc/hosts | awk '{ print $2 }'

COPY SSH KEYS:
ssh-copy-id `grep 192 /etc/hosts | awk '{ print $2 }'`
for srv in `grep 192 /etc/hosts | awk '{ print $2 }'`; do scp -r ~/.ssh/ $srv:; done

RUN COMMAND ON SEVERAL HOSTS:
pssh -A -t 1800 -v -h servers.txt -i <command> #inline output
pssh -A -t 1800 -v -h servers.txt -o <outputs-dir> <command>

mysqldump -u root -p --opt --add-drop-database -B bystrice_cz_knihovna > dump.sql

# zkopiruje soubory (cesty nacte ze souboru vstup) do $CESTY, jsou-li cesty k souborum v podslozkach, vytvori je
while read line; do install -D $line $CESTA`echo $line | cut -c 34-`; done < vstup

deborphan - najde nepouzivane zavislosti
http://www.debian-administration.org/articles/462

* find non-unicode character in file: grep -P -n "[\x80-\xFF]" file.xml

* **count files recursively in every directory**
for file in `ls -p | grep /`; do printf "`find $file | wc -l`\t$file\n"; done | sort -nr

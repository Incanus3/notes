Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2012-07-16T17:04:43+02:00

====== proftpd ======
Created Monday 16 July 2012

  proftpd s pass hash v databazi:
vytvoreni certifikatu:
openssl req -new -x509 -days 365 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem -keyout /etc/proftpd/ssl/proftpd.key.pem

vytvoreni hashe hesla:
/bin/echo "{md5}"`/bin/echo -n "password" | openssl dgst -binary -md5 | openssl enc -base64`

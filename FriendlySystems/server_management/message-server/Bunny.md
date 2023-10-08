Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-08-25T13:57:02+02:00

====== Bunny ======
Created Sunday 25 August 2013

===== logovani =====
* Bunny.new bere take logovaci optiony - vyresit, jestli a jak resit logovani
	* zda pouzivat logovaci optiony server-managementu, nebo logovat oddelene
	* zda logovat rucne v message-serveru, nebo nechat logovat Bunnyho, ci kombinovat


* bunny closes channel after exception (e.g. redeclaration of resource with incompatible options)
	* implement private reader channel, that opens a new channel, if the existing one has been closed

===== testovani =====
* bunny vyvojari testuji jednoduse sleepem
	* test posila n zprav pres 5 consumeru, kazdy zpravu prijme a posle do dalsi exchange, t = n / 1000 * 3.0; sleep(t)
	* prijme je v takovem poradi, v jakem je poslal - publish je synchronni a fronty jsou fifo
 /home/jakub/.rvm/gems/ruby-1.9.3-p448@server-management/gems/bunny-0.10.7/spec/higher_level_api/integration

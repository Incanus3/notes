Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-30T14:39:49+01:00

====== ex commands ======
Created Saturday 30 November 2013

* :e - edit file
* :w - write changes
* :q - quit
* :q! - don't prompt for saving
* :nohlsearch - hide search matches
* :s/old/new[/g] - substitute old by new, g - all occurrences on line
	* :#,#s/... - substitute from line # to line #
	* :%s/... - every occurrence in file
	* :%s/old/new/gc - -||- with prompt whether to substitute
* :!<command> - run external command
* :r <name> - insert contents of file
	* :r !<command> - insert output of command
* :set <option> - set option (for this session)
* :help
	* show help for help
	* param - e.g. operator, c_<binding>, name of section
* completion
	* C-d - show list of options
	* <TAB> - complete

:jumps - show jump list (use C-i and C-o to go back and forward)
:changes - show change list (use g; and g, to jump between last changed positions)

* environment:
http://vim.wikia.com/wiki/Displaying_the_current_Vim_environment

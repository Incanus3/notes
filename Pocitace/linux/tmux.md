Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-25T21:19:44+01:00

====== tmux ======
Created Monday 25 November 2013

===== status line =====
Character pair    Replaced with
#(shell-command)  First line of the command's output
#[attributes]     Colour or attribute change
#H                Hostname of local host
#h                Hostname of local host without the domain name
#F                Current window flag
#I                Current window index
#D                Current pane unique identifier
#P                Current pane index
#S                Session name
#T                Current pane title
#W                Current window name
##                A literal ‘#’

http://linux.die.net/man/3/strftime - variables usable in status-left/right

===== powerline =====
https://powerline.readthedocs.org/en/latest/installation/linux.html#installation-linux
* nainstalovat python-pip
* pip install --user git+git://github.com/Lokaltog/powerline
* zjistit, kam se nainstalovalo - pip show powerline
* pridat .local/bin do PATH
* exportovat XDG_CONFIG_HOME="$HOME/.config"
* .tmux.conf
	* source '{repository_root}/powerline/bindings/tmux/powerline.conf'
	* neprepsat status-left, status-right
* konfigurace
	* .mkdir ~/.config/powerline
	* cp -R /path/to/powerline/config_files/* ~/.config/powerline
	* editovat ~/.config/powerline/themes/tmux/default.json a colorschemes/tmux/default.json - pro kazdy segmentu musi byt colorscheme
	* testovat pomoci powerline tmux
	* segmenty zdokumentovany https://powerline.readthedocs.org/en/latest/segments/common.html

jakub@incanus:~ 2.0.0 > strace powerline tmux 2>&1 | grep tmux
**stat("~/.config/powerline/colorschemes/tmux/default.json", 0x7fffbec922f0) = -1 ENOENT (No such file or directory)**
stat("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/tmux/default.json", {st_mode=S_IFREG|0644, st_size=1406, ...}) = 0
lstat("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/tmux", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/tmux/default.json", {st_mode=S_IFREG|0644, st_size=1406, ...}) = 0
inotify_add_watch(3, "/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/tmux/default.json", IN_DELETE_SELF|IN_MOVE_SELF|IN_ONLYDIR) = -1 ENOTDIR (Not a directory)
inotify_add_watch(3, "/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/tmux/default.json", IN_MODIFY|IN_ATTRIB|IN_DELETE_SELF|IN_MOVE_SELF) = 3
open("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/tmux/default.json", O_RDONLY) = 4
**stat("~/.config/powerline/themes/tmux/default.json", 0x7fffbec921b0) = -1 ENOENT (No such file or directory)**
stat("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/themes/tmux/default.json", {st_mode=S_IFREG|0644, st_size=605, ...}) = 0
lstat("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/themes/tmux", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/themes/tmux/default.json", {st_mode=S_IFREG|0644, st_size=605, ...}) = 0
inotify_add_watch(3, "/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/themes/tmux/default.json", IN_DELETE_SELF|IN_MOVE_SELF|IN_ONLYDIR) = -1 ENOTDIR (Not a directory)
inotify_add_watch(3, "/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/themes/tmux/default.json", IN_MODIFY|IN_ATTRIB|IN_DELETE_SELF|IN_MOVE_SELF) = 4
open("/home/jakub/.local/lib/python2.7/site-packages/powerline/config_files/themes/tmux/default.json", O_RDONLY) = 4

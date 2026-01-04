http://pragprog.com/book/bhtmux/tmux - tmux book
https://github.com/aziz/tmuxinator - manage tmux project sessions
http://zanshin.net/2013/09/05/my-tmux-configuration/
https://github.com/square/maximum-awesome - nice vim (and tmux) settings
https://github.com/thoughtbot/dotfiles - thoughtbot config files - vim, tmux, git, bash aliases
### status line
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
`##`                A literal ‘#’

http://linux.die.net/man/3/strftime - variables usable in status-left/right
### powerline
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
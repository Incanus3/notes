Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-06-11T04:30:49+02:00

====== archlinux ======
Created Tuesday 11 June 2013

* lokalizace:
	* /etc/locale.conf
LANG='en_US.UTF-8'
	* /etc/vconsole.conf
KEYMAP='cz-qwertz'
	* /etc/X11/xorg.conf.d/10-keyboard.conf
Section "InputClass"
    Identifier		"Keyboard Defaults"
    MatchIsKeyboard	"yes"
    Option		"XkbLayout" "cz"
EndSection

* zsh - nastavit jako default shell
	* grml-zsh-config
	* prompt grml-large - pouzivat dvouradkovy prompt - vlozit do .zshrc
	* [[~/Dropbox/config/zshrc]] zkopirovat do /etc/zsh/zshrc
* nastaveni git v [[Pocitace:git]]
* instalovane baliky v [[~/Dropbox/archlinux-packages]] , skript [[~/Dropbox/archlinux-packages.install]]
* odkomentovat Color v [[/etc/pacman.conf]]

systemd - systemctl, journalctl

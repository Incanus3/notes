Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-08-15T12:59:42+02:00

====== gentoo ======
Created Thursday 15 August 2013

genkernel --loglevel=5 --color --menuconfig --symlink all

* If you want to enable Portage completions and Gentoo prompt,
* emerge app-shells/zsh-completion and add
* autoload -U compinit promptinit
* compinit
* promptinit; prompt gentoo
* to your ~/.zshrc
* 
* Also, if you want to enable cache for the completions, add
* zstyle ':completion::complete:*' use-cache 1
* to your ~/.zshrc

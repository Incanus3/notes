Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-02T11:09:01+01:00

====== bash ======
Created Saturday 02 November 2013

===== prompt =====
''PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\] $(~/.rvm/bin/rvm-prompt v g)\[\033[01;36m\]$(__git_ps1 " (%s)")\[\033[01;32m\] > \[\033[00m\]'''

===== globbing =====
shopt -s extglob
shopt -s globstar
# may break completion
shopt -s nullglob

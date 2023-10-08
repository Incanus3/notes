Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-27T03:47:48+01:00

====== vim ======
Created Wednesday 27 November 2013

http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
http://www.glump.net/howto/desktop/vim-graphical-cheat-sheet-and-tutorial - pdf version of tutorial
http://www.viemu.com/a-why-vi-vim.html
http://www.fprintf.net/vimCheatSheet.html
http://michael.peopleofhonoronly.com/vim/
http://naleid.com/blog/2010/10/04/vim-movement-shortcuts-wallpaper

http://learnvimscriptthehardway.stevelosh.com/
http://vim.wikia.com/wiki/Vim_Tips_Wiki
http://vimcasts.org/
http://got-ravings.blogspot.cz/search/label/vim
http://blog.venthur.de/index.php/2013/09/what-are-the-most-popular-vimrc-options/

http://tedlogan.com/techblog3.html - secrets of tabs in vim
* :set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
* tabstop - how many columns a tab counts for, this is the only command here that will affect how existing text displays
* softtabstop - how many columns vim uses when you hit Tab in insert mode
* shiftwidth - how many columns text is indented with the reindent operations (<< and >>) (and automatic indentation)
* expandtab - hitting Tab in insert mode will produce the appropriate number of spaces

http://got-ravings.blogspot.cz/2008/08/vim-pr0n-making-statuslines-that-own.html - customizing status line
https://github.com/bling/vim-airline - powerline alternative

http://vim.wikia.com/wiki/Indenting_source_code
http://vim.wikia.com/wiki/Great_wildmode/wildmenu_and_console_mouse - complete : commands (don't immediately iterate over them)
http://vim.wikia.com/wiki/Folding

* map leader commands - map <Leader>gc - :Gcommit -m -a ""<LEFT>

* :h - tons of useful stuff on the main page - quickref, getting started, editing effectively

=== Completion ===
* :h ins-completion
* C-n / C-p - next/previous completion
* C-x C-u - user defined completion - used by vim-rails
* C-x C-o - omni completion
* C-x C-f - file name completion
* C-x C-n - complete words from current file
* C-x C-l - complete lines from current file

file:///home/jakub/Desktop/vim/instructions.html
file:///home/jakub/Desktop/vim/cheatsheet.html

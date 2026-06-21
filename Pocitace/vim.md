# Vim

## Cheat sheets / tutorials

- http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html - graphical vi/vim cheat sheet and tutorial.
- http://www.glump.net/howto/desktop/vim-graphical-cheat-sheet-and-tutorial - PDF version of the graphical vi/vim cheat sheet tutorial.
- http://www.viemu.com/a-why-vi-vim.html - explanation of why vi/vim is useful.
- http://www.fprintf.net/vimCheatSheet.html - Vim cheat sheet.
- http://michael.peopleofhonoronly.com/vim/ - Vim cheat sheet for programmers.
- http://naleid.com/blog/2010/10/04/vim-movement-shortcuts-wallpaper - Vim movement shortcuts wallpaper.

## Learning resources / blogs

- http://learnvimscriptthehardway.stevelosh.com/ - Learn Vimscript the Hard Way.
- http://vim.wikia.com/wiki/Vim_Tips_Wiki - Vim Tips Wiki.
- http://vimcasts.org/ - Vimcasts screencasts.
- http://got-ravings.blogspot.cz/search/label/vim - Vim posts from got-ravings.
- http://blog.venthur.de/index.php/2013/09/what-are-the-most-popular-vimrc-options/ - article about popular `.vimrc` options.
- http://www.moolenaar.net/habits.html - Bram Moolenaar's “Seven habits of effective text editing”.
- http://robots.thoughtbot.com/integrating-vim-into-your-life - Thoughtbot article about integrating Vim into everyday work.
- http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally - Thoughtbot article about using Vim splits more naturally.
- http://robots.thoughtbot.com/vim-you-complete-me - Thoughtbot article about Vim completion with YouCompleteMe.

## Tabs / indentation / statusline

- http://tedlogan.com/techblog3.html - article about tabs and indentation in Vim.

Useful indentation settings:

```vim
:set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
```

- `tabstop` - how many columns a tab counts for; this is the only command here that affects how existing text displays.
- `softtabstop` - how many columns Vim uses when you hit Tab in insert mode.
- `shiftwidth` - how many columns text is indented with reindent operations (`<<` and `>>`) and automatic indentation.
- `expandtab` - hitting Tab in insert mode produces the appropriate number of spaces.

Statusline resources:

- http://got-ravings.blogspot.cz/2008/08/vim-pr0n-making-statuslines-that-own.html - article about customizing the Vim statusline.
- https://github.com/bling/vim-airline (last update 06/2026) - lightweight Vim statusline/tabline plugin and Powerline alternative.

## Editing features

- http://vim.wikia.com/wiki/Indenting_source_code - Vim wiki article about indenting source code.
- http://vim.wikia.com/wiki/Great_wildmode/wildmenu_and_console_mouse - Vim wiki article about wildmenu and command completion.
- http://vim.wikia.com/wiki/Folding - Vim wiki article about folding.

Leader command example:

```vim
map <Leader>gc :Gcommit -m -a ""<LEFT>
```

Help notes:

- `:h` - main help page has lots of useful material: quick reference, getting started, and editing effectively.

## Completion

- `:h ins-completion` - insert-mode completion help.
- `C-n` / `C-p` - next/previous completion.
- `C-x C-u` - user-defined completion, used by vim-rails.
- `C-x C-o` - omni completion.
- `C-x C-f` - file name completion.
- `C-x C-n` - complete words from current file.
- `C-x C-l` - complete lines from current file.

https://codecompanion.olimorris.dev/ - AI coding, vim style

https://github.com/tpope/vim-pathogen
https://github.com/tpope/vim-rails
* :Rfind
* gf works for many things - require, class names, associations, controller name in routes,
  partial name, named route (to action)
* :Runittest, Rfunctionaltest, ...
  * :RVunittest - with vsplit
  * :RTunittest - in new tab

https://github.com/tpope/vim-bundler
* :Bundle, :Bopen (:Bsplit,:Btabedit,...)
* highlight in Gemfile, gf in Gemfile.lock
* tags include gems path
https://github.com/nelstrom/vim-textobj-rubyblock.git - text object for ruby block
* e.g. vir - select body of ruby block / method / class
  * var - select including begin,end
  * repeate var to select outer block, vir to select inner block
* cir - edit this body, ...
* vim - inner method
* viM - inner class
* :h vim-ruby
* :h ruby-text-objects

http://net.tutsplus.com/sessions/vim-essential-plugins/

https://github.com/Lokaltog/vim-easymotion - use \<motion> instead of just <motion> to mark each position with a letter for quick jump
* e.g. w jumps over beginnings of words, \w marks each beginning with a distinct letter, so you can jump right there
	* \j - mark lines downwards, etc.

https://github.com/tpope/vim-surround - change surrounding characters
* cs"' - change " to '
* ds" - delete "
* learn visual mode to use the rest
* S" - surround selection by "

https://github.com/scrooloose/nerdtree - directory structure tree
* :NERDTree, pres ? in the tree view to get help

https://github.com/tpope/vim-repeat - enable repeating of plugin changes with . (otherwise only last 'atomic' change is repeated)

https://github.com/tpope/vim-commentary - toggle code comment
* gcc - comment line
* gc<motion> - comment motion target, e.g. gc3j - comment 3 lines incuding this one
* gc in visual mode - comment selection

https://github.com/garbas/vim-snipmate - code snippets - type name of snippet and <tab>

https://github.com/tpope/vim-fugitive - git
* :Gstatus
  * C-n / C-p - move to next/previous file in listing
  * - - stage/unstage file (works in visual mode too)
  * p - git add --patch file
  * enter - open file
  * C - do a commit
* :Gdiff - vimdiff against index (stage)
  * :Gwrite in working copy (right window) or :Gread in index (left window)
    - git add % (this file) - overwrite stage
  * :Gwrite in index or :Gread in working copy - git checkout - overwrite working copy by stage
  * :diffget (do) in index - stage change under cursor
  * :diffget in index while visually selected some lines - stage only those lines
  * :diffput in working copy - stage change under cursor

https://github.com/jeffkreeftmeijer/vim-numbertoggle

https://github.com/Raimondi/delimitMate - close delimiters - (), {}, "", ...

https://github.com/vim-scripts/zim-syntax - highlight zim files
* C-t C-z - create zim header

https://github.com/tpope/vim-eunuch - vim sugar for common shell commands
* :Remove, :Move, :Chmod, :Find, :Locate, :SudoWrite, :W

* scripting vim in ruby
  * https://github.com/lukaszkorecki/vim-GitHubDashBoard
  * https://github.com/sjbach/lusty

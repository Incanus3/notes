`:h index` - list of all commands
### motions
* hjkl - left, down, up, right
* w - start of next word
* e - end of this word
* b - beginning of this word
* $ - end of line
* 0 - beginning of line
* ^/+/- - first non-ws char on this/next/previous line
* H - screen top
* L - screen bottom
* M - screen middle
* () - beg/end of sentence
* {} - beg/end of paragraph
* `t<char>` - forward before char
* `f<char>` - forward on char
* `<number><motion>` - repeat motion
* `%` go to matching ), ], or } and back
* G - go to EOF
* <number>G - go to line <number>
* searching (/, ?) works as motion, so we can do d/ge<cr> and the text between cursor and first occurrence of "ge" is deleted

### commands
* u - undo
* U - undo whole line
* . - repeat last change
* x - delete character
* v - enter character-wise visual mode
* V - enter line-wise visual mode
* C-v - enter block visual mode
  * use S-i and S-a to insert/append text before/after each line of block
* gv - reselect last visual selection

=== operators ===
* <number><operator> - repeat operator
* <operator>[<number>]<motion> - combine with motion (and repeat)
* d<motion> - delete upto - motions:
* w - start of next word (this word and space)
* e - end of this word (without space)
* $ - end of this line
* ...
* dd - delete line
* c<motion> - change upto - delete upto and insert
* y<motion> - yank (copy) upto
* > - indent
* < - unindent
* = - autoindent
* duplicate y/d/c/=/</> to act on current line
* use "<register> before y/p/d/c to use that register - e.g. "ayy

=== objects ===
* aw - a word
* aW - a WORD
* as - a sentence
* ap - a paragraph
* ab - a () block
* aB - a {} block
* at - a tag
* a), a}, a>, a], a", a', a` - contents of paired characters
* alternatives with i - inner - without space
* combine with d, c, etc.

=== specials ===
• g{char} - goto
* **gf - go to file under cursor (rails.vim is very clever about this)**
  * uses :find on text under cursor
  * C-o - go back in jump list
  * C-i - go forward
  * C-w gf - open in new tab
  * :set suffixesadd+=.rb - try to add .rb to file name under cursor
  * uses path to find files, adjust it to your needs (vim-rails, vim-rake and vim-bundler does this)
* go to last point and insert
* g] - go to definition (using ctags) - :tselect, C-] - :tag, g C-] - :tjump
* gt - go to next tab
* gg - go to beginning of file
* gi - go to last insert point
* gu - change to lower case
* gU - change to upper case
* g~ - swap case
* z{char} - scroll cursor
* zt - top, zb - bottom, zz - center
* Z{char} - quit
* ZZ - with save
* ZQ - w/o save
* [,] - jump to various things - start/end of methods, classes, blocks, ...
  * :h [
* % - jump between (), {}, [], do-end (requires matchit)

=== shortcuts ===
* A = $a
* => A<action>ESC - save action with movement to EOL
* j. - reply movement on next line
* C = c$
* s = cl - delete right (current) char and insert
* S = ^C = ^c$ - change (delete and insert) whole line
* I = ^i - insert to beginning of line
* o = A<CR> - insert after this line
* O = ko - insert before this line

=== copy & paste ===
* y - yank (command) - :yank = copy
* yy/Y - yank line
* d - delete (command) - :delete = cut
* p - put deleted text after cursor / on next line (when whole line deleted) - :put = paste
  * character-wise register (e.g. by dw) inserts after cursor
  * line-wise register (e.g. by dd) inserts after line
* P - put before cursor / on previous line
* gp/gP - put before/after cursor/line, position the cursor at the end of put text
* in visual mode, p REPLACES the selection
  {start} _I like chips and fish.
  fc      I like _chips and fish.
  de      I like _ and fish.
  mm      I like _ and fish. - make mark
  ww      I like  and _fish.
  ve      I like  and <fish>.
  p       I like  and _chips. - replace selection
  `m      I like _ and chips. - jump back to mark
  P       I like fis_h and chips. - put before cursor
* prefix by "{register} to use non-default register
* "{a-z} - named registers
* "ay - yank to reg. a, overwriting it
* "Ay - yank to reg. a, appending to it
* "" - the unnamed (default) register - ""dd = dd, commands x, s, d, c and y use this by default
* "0 - the yank register - y stores to "" and "0, but "0 isn't overwritten by x, s, d and c
* "_ - the black hole register (e.g. when we want to copy a word and then replace another one by it - if we used e.g. ciw to change the second word, it would be stored in default register, overriding the first one - use "_ciw for the second word)
* :reg [registers] - inspect contents of registers
* "% - holds name of current file, "# - holds name of alternate file
* ". - last inserted text
* ": - holds last command
* "/ - last search pattern
* "+ - system clipboard register (if vim compiled with support for it)
* "* - system selection register (-||-) - like the middle mouse button
* "= - the expression register - "={expression}, then :put =, :h quote= for more

=== searching ===
* / - forward search
	* end with \c to ignore case
* ? - backward search
* n - next match
* N - previous match
* *  - start a search for word under cursor

=== misc ===
* v - enter visual mode
	* :w <name> after selection - write only this part of file
	* or use an operator to do something with the text
* >G - increase indentation of current line
* r - replace current char
	* R - enter replace mode

=== marks ===
* m{a-z} - make buffer-local mark
* m{A-Z} - make global mark - should be persisted between sessions
* '{mark} - jump to mark line
* `{mark} - jump to mark
* automatic marks:
`` Position before the last jump within current file
`. Location of last change
`^ Location of last insertion
`[ Start of last change or yank
`] End of last change or yank
`< Start of last visual selection
`> End of last visual selection

=== repetitions ===
* . - repeat last change
* ; - repeat last find (f{char} / t{char})
* , - repeat last find in reverse direction (F{char} / T{char})
* @: - repeat command
* & - repeat last substitution

=== macros ===
* q{register}{changes}q - record changes into register
* [{count}]@{register} - replay changes from register
* @@ - replay the last played macro
* when count used and vim runs into errors (e.g. can't make the motion), the execution is aborted
* we can avoid this by using visual mode - make selection, then :normal @{reg}
* macros can be inspected as normal registers using :reg [{reg}]
* use uppercase register to append to it
* build a list of files using :args, record a macro and run it on the file list using :argdo normal @a
* or include the call to :next in the macro and then just run it with count, this way it stops on error
* iterate over numbers in macros:
:let i=1            partridge in a pear tree - initialize a variable
qa                  partridge in a pear tree - start recording macro
I<C-r>=i<CR>) <Esc> 1) partridge in a pear tree - insert variable using expression register
:let i += 1         1) partridge in a pear tree - increment variable
q                   1) partridge in a pear tree - stop recording
* edit recorded macro by putting it from the register, editing and then yanking back into register

=== bindings ===
* C-g - show file status
* C-o - go back where you came from
* C-i - go forward (in history)
* C-d - command line completions
* C-w C-w - jump between windows
* [n] C-y / C-e - scroll n lines up/down
* [n] C-u / C-d - scroll n half screens up/down
* [n] C-b / C-f - scroll n windows up/down

* [n] C-a / C-x - add / substract n to number (under cursor or forward)

== insert mode ==
* C-h - delete back one char
* C-w - delete back one word
* C-u - delete back to start of line

* C-[ / C-c - switch to normal mode
* C-o - switch to insert normal mode (one command, then back to insert)

* C-r N - paste from yank register N (0 is the last yank)
  * C-r = - paste from expression register
  * C-r + - paste from clipboard (if enabled)

* C-n - find next keyword (completion)
* C-p - find previous keyword

* C-t - indent
* C-d - unindent

== visual mode ==
* o - go to other end of selection

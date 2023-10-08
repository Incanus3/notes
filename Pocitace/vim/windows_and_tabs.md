Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-30T14:41:09+01:00

====== windows and tabs ======
Created Saturday 30 November 2013

=== files ===
:e[dit] {files} (:Ve - vsplit)
:E - open explorer for directory of current file = :e %:h (:Sexplore, :Vexplore)
* :h netrw - file explorer can do other things - e.g. open files over network
:clo[se]
:pwd
:cd
:find - finds files in path
:set path+=app/**
* create file in nonexistent directory:
:!mkdir -p %:h
:w[rite]
:wn = :write, :next
* write file as root:
:w !sudo tee % > /dev/null

=== tabs ===
:h tabpage
:tabnew
:tabedit [file] (C-w T)
:tabc[lose], :tabonly
:tabn[ext] - gt - go to next tab
:tabp[revious] - gT - go to previous tab
:tabn[ext] <number> - <number>gt - go to tab number <number>
:tabm[ove] [+/-][N]

=== windows ===
http://vimcasts.org/episodes/working-with-windows/
:h windows

C-w s - horizontal split
C-w v - vertical split
C-w h/j/k/l - move between windows
C-w c - close window
C-w o - close all other windows
C-w r - rotate windows
C-w R - rotate backwards
[number] C-w +/- change size
<C-w>= Equalize width and height of all windows
<C-w>_ Maximize height of the active window
<C-w>| Maximize width of the active window
[N]<C-w>_ Set active window height to [N] rows
[N]<C-w>| Set active window width to [N] columns

CTRL-W +	   increase current window height N lines
CTRL-W -	   decrease current window height N lines
CTRL-W <	   decrease current window width N columns
CTRL-W =	   make all windows the same height & width
CTRL-W >	   increase current window width N columns
CTRL-W H	   move current window to the far left
CTRL-W J	   move current window to the very bottom
CTRL-W K	   move current window to the very top
CTRL-W L	   move current window to the far right
CTRL-W P	   go to preview window
CTRL-W R	   rotate windows upwards N times
CTRL-W T	   move current window to a new tab page
CTRL-W W	   go to N previous window (wrap around)
CTRL-W ]	   split window and jump to tag under cursor
CTRL-W ^	   split current window and edit alternate file N
CTRL-W _	   set current window height to N (default: very high)
CTRL-W b	   go to bottom window
CTRL-W c	   close current window (like |:close|)
CTRL-W d	   split window and jump to definition under the cursor
CTRL-W f	   split window and edit file name under the cursor
CTRL-W F	   split window and edit file name under the cursor and jump to the line number
CTRL-W g CTRL-]  split window and do |:tjump| to tag under cursor
CTRL-W g ]	   split window and do |:tselect| for tag under cursor
CTRL-W g }	   do a |:ptjump| to the tag under the cursor
CTRL-W g f	   edit file name under the cursor in a new tab page
CTRL-W g F	   edit file name under the cursor in a new tab page and jump to the line number following the file name.
CTRL-W h	   go to Nth left window (stop at first window)
CTRL-W i	   split window and jump to declaration of identifier under the cursor
CTRL-W j	   go N windows down (stop at last window)
CTRL-W k	   go N windows up (stop at first window)
CTRL-W l	   go to Nth right window (stop at last window)
CTRL-W n	   open new window, N lines high
CTRL-W o	   close all but current window (like |:only|)
CTRL-W p	   go to previous (last accessed) window
CTRL-W q	   quit current window (like |:quit|)
CTRL-W r	   rotate windows downwards N times
CTRL-W s	   split current window in two parts, new window N lines high
CTRL-W t	   go to top window
CTRL-W v	   split current window vertically, new window N columns wide
CTRL-W w	   go to N next window (wrap around)
CTRL-W x	   exchange current window with window N (default: next window)
CTRL-W z	   close preview window
CTRL-W |	   set window width to N columns

=== buffers ===
http://vimcasts.org/episodes/working-with-buffers/
:buffer [n]
:bnext [n]
:bprevious [n]
:bfirst
:blast
* :bnext, :bprev, :next, :cnext etc. don't let you abandon buffers if there're pending changes, use :bnext! et al. or :hide
:ball
* prepend with s to split
* C-^ - alternate last buffers
* ,bc - :Bclose - close buffer without closing window

:files, :buffers, :ls
:badd,:bdelete
:hide
:vert sb N - open buffer in vert split
* when quiting vim, it asks you to save all modified buffers (including hidden), use
:w - selectively
:e! - reload file from disk (discard changes)
:qa! - discard all changes
:wa - save all changes

=== args ===
* if you want to focus on a group of files, populate arglist by
:args files (with possible wildcards or `` expansion)
* then switch between them using :next and :prev
* list them by :args
* iterate using :argdo

=== quickfix list ===
* populated e.g. by :make or :grep, jump between items using:
:cnext Jump to next item
:cprev Jump to previous item
:cfirst Jump to first item
:clast Jump to last item
:cnfile Jump to first item in next file
:cpfile Jump to last item in previous file
:cc N Jump to nth item
:copen Open the quickfix window
:cclose Close the quickfix window
:colder, :cnewer - recall results from previous quickfix lists

* very similar to location list - for manually created file with locations

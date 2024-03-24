* M-x eshell - shell inside emacs
* C-h b - describe bindings - shows available key bindings, grouped by modes

* ido mode
C-j Use the current input string verbatim.
C-s Put the first element at the end of the list.
C-r Put the last element at the start of the list.
TAB Complete a common suffix to the current string that
matches all files.  If there is only one match, select that file.
If there is no common suffix, show a list of all matching files
in a separate window.
C-d Open the specified directory in Dired mode.
C-e Edit input string (including directory).
M-p or M-n go to previous/next directory in work directory history.
M-s search for file in the work directory history.
M-k removes current directory from the work directory history.
M-o or C-M-o cycle through the work file history.
M-f and M-d prompts and uses find to locate files or directories.
M-m prompts for a directory to create in current directory.
C-x C-f Fallback to non-ido version of current command.
C-t Toggle regexp searching.
C-p Toggle between substring and prefix matching.
C-c Toggle case-sensitive searching of file names.
M-l Toggle literal reading of this file.
? Show list of matching files in separate window.
C-a Toggle ignoring files listed in `ido-ignore-files'.

* robe
C-c C-d - robe-doc - zobrazi ri dokumentaci v okne, jakmile se jednou aktivuje robe, zobrazuje popisky ve status baru

==== kopirovani jednoho textu v emacsu na vice mist tak, abych pri vyjmuti jineho textu neprepsal kopii v bufferu ====
Don't use the kill ring; put the text into a register instead. 'C-x r s a' (register store a) to store the region's text into (say) register "a";
  then 'C-x r i a' (register insert a) to insert it elsewhere.
You could use M-x delete-region instead to kill the text, possibly binding it to a key if you want to use it a lot.


https://github.com/grundprinzip/sublemacspro - emacs mode for sublime text

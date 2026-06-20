### AI / coding assistance
- https://codecompanion.olimorris.dev/ - AI coding assistant for Vim/Neovim, designed to feel native to the editor.

### Plugin management
- https://github.com/tpope/vim-pathogen (last update 08/2022) - simple runtimepath/plugin loader for Vim plugins.

### Ruby / Rails
- https://github.com/tpope/vim-rails (last update 02/2025) - Rails-aware navigation, commands, and file handling.
  - `:Rfind`
  - `gf` works for many Rails things: `require`, class names, associations, controller names in routes, partial names, named routes.
  - `:Runittest`, `:Rfunctionaltest`, ...
    - `:RVunittest` - open with vertical split.
    - `:RTunittest` - open in a new tab.
- https://github.com/tpope/vim-bundler (last update 03/2026) - Bundler/Gemfile integration for Vim.
  - `:Bundle`, `:Bopen` (`:Bsplit`, `:Btabedit`, ...).
  - Highlights Gemfiles; `gf` works in `Gemfile.lock`.
  - Tags include gem paths.
- https://github.com/nelstrom/vim-textobj-rubyblock (last update 08/2018) - text objects for Ruby blocks/classes/methods.
  - `vir` - select body of Ruby block / method / class.
  - `var` - select including `begin`/`end`.
  - Repeat `var` to select an outer block, `vir` to select an inner block.
  - `cir` - edit block body.
  - `vim` - inner method.
  - `viM` - inner class.
  - See `:h vim-ruby` and `:h ruby-text-objects`.

### Navigation / text objects
- https://github.com/Lokaltog/vim-easymotion (last update 02/2024) - marks motion targets with letters for quick jumps.
  - Example: `w` jumps over word beginnings; `\w` marks each beginning with a distinct letter so you can jump directly there.
  - `\j` marks lines downward.
- https://github.com/tpope/vim-surround (last update 06/2024) - change, delete, and add surrounding characters.
  - `cs"'` - change `"` to `'`.
  - `ds"` - delete surrounding `"`.
  - `S"` - surround visual selection with `"`.

### Editing helpers
- https://github.com/tpope/vim-repeat (last update 07/2024) - makes plugin changes repeatable with `.`.
- https://github.com/tpope/vim-commentary (last update 10/2024) - comment/uncomment lines and motions.
  - `gcc` - comment line.
  - `gc<motion>` - comment motion target, e.g. `gc3j` comments three lines including the current one.
  - `gc` in visual mode - comment selection.
- https://github.com/Raimondi/delimitMate (last update 08/2024) - auto-closes delimiters like `()`, `{}`, and quotes.

### Files / project tree / shell helpers
- https://github.com/scrooloose/nerdtree (last update 09/2025) - directory tree sidebar.
  - `:NERDTree`; press `?` in the tree view for help.
- https://github.com/tpope/vim-eunuch (last update 12/2024) - Vim sugar for common shell/file commands.
  - `:Remove`, `:Move`, `:Chmod`, `:Find`, `:Locate`, `:SudoWrite`, `:W`.

### Git
- https://github.com/tpope/vim-fugitive (last update 03/2026) - Git integration inside Vim.
  - `:Gstatus`
    - `C-n` / `C-p` - move to next/previous file in listing.
    - `-` - stage/unstage file; works in visual mode too.
    - `p` - `git add --patch` for file.
    - `Enter` - open file.
    - `C` - commit.
  - `:Gdiff` - vimdiff against index/stage.
    - `:Gwrite` in working copy or `:Gread` in index - stage this file / overwrite stage.
    - `:Gwrite` in index or `:Gread` in working copy - checkout this file / overwrite working copy from stage.
    - `:diffget` (`do`) in index - stage change under cursor.
    - `:diffget` in index while visually selecting lines - stage only those lines.
    - `:diffput` in working copy - stage change under cursor.

### Snippets / display / syntax
- https://github.com/garbas/vim-snipmate (last update 05/2025) - snippet expansion; type snippet name and press `<Tab>`.
- https://github.com/jeffkreeftmeijer/vim-numbertoggle (last update 07/2021) - toggles between absolute and relative line numbers.
- https://github.com/vim-scripts/zim-syntax (last update 12/2011) - syntax highlighting for old Zim wiki files.
  - `C-t C-z` - create Zim header.

### Review later / probably stale
- http://net.tutsplus.com/sessions/vim-essential-plugins/ - old Vim essential plugins article; review before relying on it.

### Cleanup note
Old Vim scripting-in-Ruby links were removed as stale: `lukaszkorecki/vim-GitHubDashBoard` (last update 08/2011) and `sjbach/lusty` (last update 07/2018).

# Vim configuration with Vim Plug
## Instructions for Installation
1. Clone this repository into the .vim directory<br>
<code>git clone https://github.com/prasada7/VimConfig.git ~/.vim</code>
2. execute the install.sh script to complete the setup<br>
> this script creates necessary directories and backs up any old vim config file if it exists and triggers the installation process with vim plug <br>

## Plugins included
1. [NERDTree](https://github.com/scrooloose/nerdtree)
2. [Lightline](https://github.com/itchyny/lightline.vim)
3. [Multicursors ](https://github.com/terryma/vim-multiple-cursors)
4. [Emmet](https://github.com/mattn/emmet-vim)
5. [Git Gutter](https://github.com/airblade/vim-gitgutter)
6. [Gruvbox](https://github.com/morhetz/gruvbox)
7. [(React) Java Script Syntax](https://github.com/pangloss/vim-javascript)
8. [SnipMate](https://github.com/garbas/vim-snipmate)
9. [Surround](https://github.com/tpope/vim-surround)
10. [Git Fugitive](https://github.com/tpope/vim-fugitive)
11. [Css color](https://github.com/ap/vim-css-color)
12. [Supertab](https://github.com/ervandew/supertab)
13. [Repeat](https://github.com/tpope/vim-repeat)
14. [FZF](https://github.com/junegunn/fzf)
15. [JSON manipulation](https://github.com/tpope/vim-jdaddy)
16. [Seoul256 colorscheme](https://github.com/junegunn/seoul256.vim)
17. [Indentation lines](https://github.com/Yggdroot/indentLine)
18. [Match tags](https://github.com/valloric/matchtagalways)
19. [Commenting helper](https://github.com/scrooloose/nerdcommenter)
20. [Git commit browser](https://github.com/junegunn/gv.vim)
21. [Auto close tags](https://github.com/alvan/vim-closetag)
22. [Brackets completion/deleting and so on](https://github.com/jiangmiao/auto-pairs)
23. [Apprentice colorscheme (default)](https://github.com/romainl/Apprentice)
24. [Async build and test dispatcher](https://github.com/tpope/vim-dispatch)
25. [Async linter](https://github.com/w0rp/ale)
26. [Intellisense for Vim8](https://github.com/neoclide/coc.nvim)
27. [Trailing whitespace highlighter](https://github.com/ntpeters/vim-better-whitespace)
28. [Node environment helper for Vim](https://github.com/moll/vim-node)
29. [Most recently used files](https://github.com/pbogut/fzf-mru.vim)
30. [Dockerfile syntax](https://github.com/ekalinin/Dockerfile.vim)
31. [Ctrl P for environments where FZF cant be installed](https://github.com/kien/ctrlp.vim)

## Features included in this configuration
* Trailing whitespaces are always highlighted
* All trailing whitespaces can be removed by pressing F2 or entering
<code>:Trailing</code>
* The Color Column is set at the 80th column
* Line numbers are enabled by default (could be disabled by entering
<code>:set nonu</code>)
* Mouse support can be togged using F3
* Use F5 to save a file
* Use q in normal mode to close a window (force quit is not remapped)
* Use F4 to toggle the NERDTree Plugin
* Tabs changed to four spaces
* Ctrl + F to do a global search in the current working directory and <F6> to
bring up the QuickFix list in a new tab
* F7 to stop highlighting but continue highlighting trailing white spaces
* Ctrl-P to open fuzzy finder using fzf. Visit
[FuzzyFinder](https://github.com/junegunn/fzf) for more info
* Alt Up/Down to move a line upwards or downwords (Normal mode)
* Alt Left/Right to move cursor to the beginning or end of the line (Normal
mode)
* Shit + Tab to outdent a line in insert mode
* Ctrl + A to highlight the entire file
* \\[gs|gb|gd] mapped to Gstatus, Gblame, and Gdiff respectively. '\' is the
default Leader character in Vim
* And more... Please take a look at the config file :)
> For more information on NERDTree visit this
[link](https://github.com/scrooloose/nerdtree)


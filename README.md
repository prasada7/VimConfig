# Vim configuration with Vundle
## Instructions for Installation
1. Clone this repository into the .vim directory<br>
<code>git clone https://github.com/prasada7/VimConfig.git</code>
2. Execute the installVundle.sh script to complete the setup<br>
> This file clones the Vundle repoitory from github into the ~/.vim/bundledir
ectory, creates a sym link to the .vimrc present in this repository from the
~ directory, and runs :PluginInstall to install all the specified plugins<br>

## Plugins included
1. Vundle [VundleVim/Vundle.vim]
2. NERDTree [scrooloose/nerdtree]
3. Lightline [itchyny/lightline.vim]
4. Multicursors  [terryma/vim-multiple-cursors]
5. Emmet [mattn/emmet-vim]
6. Git Gutter [airblade/vim-gitgutter]
7. Gruvbox [morhetz/gruvbox]
8. (React) Java Script Syntax [pangloss/vim-javascript] and [mxw/vim-jsx]
9. SnipMate [garbas/vim-snipmate]
10. Surround [tpope/vim-surround]
11. Git Fugitive [tpope/vim-fugitive]
12. Css color [ap/vim-css-color]
13. Supertab [ervandew/supertab]
14. Repeat [tpope/vim-repeat]
> Use the text within the brackets to go to the plugins respective git repo<br>
For example, Repeat's git repo is https://github.com/tpope/vim-repeat

## Features included in this configuration
* Trailing whitespaces are always highlighted
* All trailing whitespaces can be removed by pressing F2 or entering
<code>:Trailing</code>
* The Color Column is set at the 80th column
* Line numbers are enabled by default (could be disabled by entering
<code>:set nonu</code>)
* Mouse support can be togged using F3
* Ctrl+x (Visual mode cut) and Ctrl+v (insert mode paste)
* Use F5 to save a file
* Use q in normal mode to close a window (force quit is not remapped)
* Use F4 to toggle the NERDTree Plugin
* Tabs changed to four spaces
* Ctrl + F to do a global search in the current working directory and <F6> to
bring up the QuickFix list in a new tab
* F6 to stop highlighting but continue highlighting trailing white spaces
* Ctrl-P to open fuzzy finder using fzf (if installed) visit
[FuzzyFinder](https://github.com/junegunn/fzf) for instructions
* Alt Up/Down to move a line upwards or downwords (Normal mode)
* Alt Left/Right to move cursor to the beginning or end of the line (Normal
mode)
* Shit + Tab to outdent a line in insert mode
* Ctrl + A to highlight the entire file
* \\[gs|gb|gd] mapped to Gstatus, Gblame, and Gdiff respectively. '\' is the
default Leader character in Vim
> For more information on NERDTree visit this
[link](https://github.com/scrooloose/nerdtree)

## Making use of the Vundle Plugin installer
* To search for a plugin, use <code>:BundleSearch</code>
* To install a plugin, simply add <code>Plugin '[Name]'</code> to the .vimrc
and call <code>:PluginInstall</code> in vim<br>
* For more information please visit the
[official github page](https://github.com/VundleVim/Vundle.vim) for Vundle
>*TIP: Simply copy the line that resulted from the <code>:BundleSearch</code>*
  *into the .vimrc*<br>


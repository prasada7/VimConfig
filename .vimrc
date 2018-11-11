set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Include fuzzy finder
set rtp+=~/.fzf

"""""""""""""""""""""""""""""""""Plugins for Vim"""""""""""""""""""""""""""""""
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mattn/emmet-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'morhetz/gruvbox'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'ap/vim-css-color'
Plugin 'ervandew/supertab'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""Functionality""""""""""""""""""""""""""""""""""
" Set tab to four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap

" Enable auto indentation
set autoindent

" Add starstart to the and enable wildmenu
set path+=**
set wildmenu

" Show the command being typed while in normal mode
set showcmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""Visual configurations""""""""""""""""""""""""""""""
" Set the default color to desert and background color to grey
silent! color gruvbox
set background=dark
hi Normal ctermbg=234

" Remove the introductory message
set shortmess=I

" Display the status line and change its color
set laststatus=2
hi StatusLine ctermfg=235
hi StatusLine ctermbg=244

" Set the character count marker at 80
hi ColorColumn ctermbg=235
let &colorcolumn="80".join(range(79,1000),",")

" Highlight all trailing white spaces
set hlsearch
silent! /\s\+$
hi Search ctermbg=235

" Set the non text region background to grey as well
hi NonText ctermbg=235

" Enable and configure line count
set nu
hi LineNr ctermbg=235
hi LineNr ctermfg=244

" Highlight cursor line (highlights on insert mode)
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
hi clear CursorLine

" Customize the tabline and the status line
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode' ],
    \             [ 'gitbranch', 'readonly', 'filenamebuf', 'modified' ] ]
    \ },
    \ 'enable': {
    \    'statusline': 1,
    \    'tabline': 0
    \ },
    \ 'component': {
    \    'filenamebuf': '%f[%n]'
    \ },
    \ 'component_function': {
    \    'gitbranch': 'fugitive#head'
    \ }
    \ }
hi TablineSel ctermbg=234
set showtabline=2
set noshowmode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""Custom Mappings"""""""""""""""""""""""""""""""""
" Map the Nerd tree toggle to F4, set igrnore options, and show hidden files
nnoremap <F4> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['node_modules']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" Close brackets whenever a open bracket is placed
inoremap {<CR> {<CR>}<UP><C-o>o<tab>

" Map Ctrl+x to cut in visual mode
vmap <C-x> ygvx

" Map Ctrl+v to paster in insert mode
imap <C-v> <C-o>p

" Create a command for removing white spaces and map it to F2
command Trailing execute "call Trailing()"
nnoremap <F2> :Trailing<CR>

" Map F5 to save the file
nnoremap <F5> :w<CR>

" Map q to quit window
nnoremap q :q<CR>

" Map CTRL + P For fuzzy finder
nnoremap <C-p> :FZF<CR>

" Map Alt arrow to moving a line up or down and placing cursor to start/end
nnoremap <M-UP> ddkkp
nnoremap <M-DOWN> ddp
map <M-RIGHT> <END>
map <M-LEFT> <HOME>

" Shortcut to replace the word the cursor is on
nnoremap <C-x> ciw

" Use jsx syntax for marko files
autocmd BufNewFile,BufRead *.marko set filetype=javascript.jsx

" Make shift-tab as outdent
inoremap <S-TAB> <C-d>

" CTRL-A for select all
nnoremap <C-a> ggvG$

" Use F3 to toggle mouse control
command ToggleMouse execute "call ToggleMouse()"
nnoremap <F3> :ToggleMouse<CR>

" Add maps to simplify global search
nnoremap <C-F> :vim //j **/*<left><left><left><left><left><left><left>
nnoremap <F6> :tabe \| cw<CR><C-w>10_

" Fugitive git shortcuts
nnoremap <Leader>gs :Gstatus<CR><C-w>H
nnoremap <Leader>gd :Gdiff<CR><C-w>H
nnoremap <Leader>gb :Gblame<CR><C-w>H
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""Functions""""""""""""""""""""""""""""""""""""""
" A funtion for installing Vundle
function InstallVundle()
	PluginInstall
	qa
endfunction

" A function for removing trailing white spaces
function Trailing()
    %s/\s\+$//ge
endfunction

" A function for toggling mouse control
function ToggleMouse()
    " Check if mouse is set and toggle accordingly
    if &mouse == 'a'
        set mouse=
        echo "mouse disabled"
    else
        set mouse=a
        echo "mouse enabled"
    endif
endfunction


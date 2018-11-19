" Vundle and Plugins {{{

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Include fuzzy finder
set rtp+=~/.fzf

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
Plugin 'tpope/vim-repeat'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-jdaddy'
Plugin 'junegunn/seoul256.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" }}}


" Functionality {{{

" Set tab to four spaces
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab nowrap

" Enable auto indentation
set autoindent

" Add starstart to the and enable wildmenu
set path+=** wildmenu

" Show the command being typed while in normal mode
set showcmd

" Move swap files to a directory in .vim
set directory=~/.vim/.swaps//

" Set folding method for vim files
autocmd FileType vim setlocal foldmethod=marker

" Change the trigger key for Emmet to E instead of Y
let g:user_emmet_leader_key="<C-e>"

" Use jsx syntax for marko files
autocmd BufNewFile,BufRead *.marko set filetype=javascript.jsx

" Map ZZ to lower case to prevent unintentional save and quit
nnoremap ZZ zz

" Change the way vim splits windows
set splitbelow
set splitright

" Disable ex mode
nmap Q <nop>

" Ignore cases when patern searching
set ignorecase
set smartcase

" }}}


" Visual configurations {{{
" Set the color scheme to seoul256
let g:seoul256_background = 233
set background=dark
silent! color seoul256

" Set the character count marker at 80
hi ColorColumn ctermbg=234
let &colorcolumn="80"

" Enable line count
set nu

" Set a clear cursor line
hi clear CursorLine

" Display the status line
set laststatus=2

" Remove the introductory message
set shortmess=I

" Highlight all trailing white spaces
set hlsearch
silent! /\s\+$

" Customize the status line
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
hi TablineSel ctermbg=233
set showtabline=2 noshowmode

" Customize the tabline
set tabline=%!GetLabel()

" Customize fzf
let g:fzf_layout = { 'left': '~50%' }

" Enable relative number
set rnu

" NERDTree conf
let NERDTreeIgnore = ['node_modules']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" }}}


" Custom Mappings {{{
" NORMAL MODE {{{

" Map the Nerd tree toggle to F4
nnoremap <F4> :NERDTreeToggle<CR>

" Map to list all custom mappings
nnoremap <Leader>cm :Maps<CR> ~/.vimrc

" Create a command for removing white spaces and map it to F2
command Trailing execute "call Trailing()"
nnoremap <F2> :Trailing<CR>

" Map F5 to save the file
nnoremap <F5> :w<CR>

" Map q to quit window
nnoremap <Leader>q :q<CR>

" Map CTRL + P For fuzzy finder
nnoremap <C-p> :FZF<CR>

" Map Alt arrow to moving a line up or down and placing cursor to start/end
nnoremap <M-UP> ddkkp
nnoremap <M-DOWN> ddp
map <M-RIGHT> <END>
map <M-LEFT> <HOME>
nnoremap <Leader>b ^
nnoremap <Leader>e $

" Shortcut to replace the word the cursor is on
nnoremap <C-x> ciw

" CTRL-A for select all
nnoremap <C-a> ggvG$

" Use F3 to toggle mouse control
command ToggleMouse execute "call ToggleMouse()"
nnoremap <F3> :ToggleMouse<CR>

" Add maps to simplify global search
nnoremap <C-F> :vim //j **/*<left><left><left><left><left><left><left>
nnoremap <F6> :tabe \| cw<CR><C-w>10_

" Fugitive git shortcuts
nnoremap <Leader>gs :GFiles?<CR>
nnoremap <Leader>gd :Gdiff<CR><C-w>H
nnoremap <Leader>gb :Gblame<CR><C-w>H
nnoremap <Leader>gg :GitGutter<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Gcommit<CR>

" Use <F7> to stop highlighting searchs but keep highlighting trailing
nnoremap <F7> :noh \| silent! /\s\+$<CR>

" Map to list all buffers
nnoremap <Leader>lb :Buffers<CR>

" Map to list history of files
nnoremap <Leader>lh :History<CR>

" Map to pretty print JSON files
nmap <Leader>pp gqaj

" Map to place all buffers into tabs
nnoremap <Leader>tb :tab ball<CR><CR>

" Map to close file and delete buffer
nnoremap <Leader>cf :bw<CR>

" Map to create a new tab
nnoremap <Leader>nt :tabe<CR>

" Map to locate the current file in NERDTree
nmap <Leader>ff :NERDTreeFind<CR>

" Map to open the vimrc conf file
nmap <Leader>vc :tabe ~/.vimrc<CR>

" Maps to copy and paste to clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" Maps to jump to particular tab
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

" Map to search and replace
nnoremap <C-h> :%s///g<left><left><left>

" Map to move the view up and down
nnoremap <Leader>u <C-y>
nnoremap <Leader>d <C-e>

" Use shift up/down to duplicate current line
nmap <S-down> Yp
nmap <S-up> YP

" Toggle to show special characters
nnoremap <Leader>i :set list!<CR>

" Maps to switch to filetypes
nmap _vim :set ft=vim<CR>
nmap _js :set ft=javascript.jsx<CR>
nmap _pl :set ft=perl<CR>
nmap _java :set ft=java<CR>
nmap _sh :set ft=sh<CR>
nmap _html :set ft=html<CR>

" }}}

" INSERT MODE {{{

" Close brackets whenever a open bracket is placed
inoremap {<CR> {<CR>}<UP><C-o>o<tab>

" Make shift-tab as outdent
inoremap <S-TAB> <C-d>

" }}}

" VISUAL MODE {{{

" Map Ctrl+x to cut in visual mode
vmap <C-x> ygvx

" }}}
" }}}


" Functions {{{

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

" Function to create the label for the tabline
function GetLabel()
    let s = ''
    let index = 1
    let currentTab = tabpagenr()
    " Loop through all the pages
    while index <= tabpagenr('$')
        let buflist = tabpagebuflist(index)
        let winnr = tabpagewinnr(index)
        let bufname = bufname(buflist[winnr -1])

        " Indicate the tab number and determine whether this tab is selected
        let s .= '%' . index . 'T'
        let s .= (index == currentTab ? '%#TabLineSel#' : '%#TabLine#')

        " Add the file name along with the tab number
        let s .= ' ' . index . '| ' . (bufname != ''? bufname : 'New File' )

        " Add the modifed symbol if the buffer has been modified
        let s .= (getbufvar(index, '&mod') == 1 ? '+ ' : ' ')

        let index += 1
    endwhile

    " Append the tabfill start indication
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

" }}}


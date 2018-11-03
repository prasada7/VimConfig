set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Include fuzzy finder
set rtp+=~/.fzf

" Plugins for Vim
Plugin 'VundleVim/Vundle.vim'
Plugin 'The-NERD-tree'
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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Map the Nerd tree toggle to F4
nnoremap <F4> :NERDTreeToggle<CR>

" Set the default color to desert and background color to grey
silent! color gruvbox
set background=dark
hi Normal ctermbg=234

set shortmess=I
set nowrap

" Set tab to four spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Display the status line and change its color
set laststatus=2
hi StatusLine ctermfg=235
hi StatusLine ctermbg=244

" Set the character count marker at 80
hi ColorColumn ctermbg=235
hi ColorColumn ctermfg=red
let &colorcolumn="80".join(range(79,1000),",")

" Set the non text region background to grey as well
hi NonText ctermbg=235

" Enable and configure line count
set nu
hi LineNr ctermbg=235
hi LineNr ctermfg=244

" Close brackets whenever a open bracket is placed
inoremap {<CR> {<CR>}<UP><C-o>o<tab>

" Allow the mouse to be used as a cursor
" set mouse=a

" Map Ctrl+x to cut in visual mode
vmap <C-x> ygvx

" Map Ctrl+v to paster in insert mode
imap <C-v> <C-o>p

" Highlight all trailing white spaces
set hlsearch
silent! /\s\+$
hi Search ctermbg=235

" Enable auto indentation
set autoindent

" Create a command for removing white spaces and map it to F2
command Trailing execute "call Trailing()"
nnoremap <F2> :Trailing<CR>

" Map F5 to save the file
nnoremap <F5> :w<CR>

" Map q to quit window
nnoremap q :q<CR>

" Highlight cursor line (highlights on insert mode)
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
hi clear CursorLine

" Map CTRL + P For fuzzy finder
nnoremap <C-p> :FZF<CR>

" Map Alt arrow to moving a line up or down and placing cursor to start/end
nnoremap <M-UP> ddkkp
nnoremap <M-DOWN> ddp
map <M-RIGHT> <END>
map <M-LEFT> <HOME>

" Shortcut to replace the word the cursor is on
nnoremap <C-x> ebcw

" Use jsx syntax for marko files
autocmd BufNewFile,BufRead *.marko set filetype=javascript.jsx

" A funtion for installing Vundle
function InstallVundle()
	PluginInstall
	qa
endfunction

" A function for removing trailing white spaces
function Trailing()
        %s/\s\+$//ge
endfunction


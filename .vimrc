set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'The-NERD-tree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Map the Nerd tree toggle to F4
nnoremap <F4> :NERDTreeToggle<CR>

" Set the default color to desert
silent! color desert

" Set tab to four spaces
set tabstop=4
set expandtab

" Set the character count marker at 80
set cc=80
hi ColorColumn ctermbg=Cyan

" Close brackets whenever a open bracket is placed
inoremap {<CR> {<CR>i<CR>}<UP><bs><tab>
inoremap ( ()<LEFT>
inoremap () ()
inoremap [ []<LEFT>
inoremap [] []

" Allow the mouse to be used as a cursor
set mouse=a

" Map Ctrl+x to cut in visual mode
vmap <C-x> ygvx

" Map Ctrl+v to paster in insert mode
imap <C-v> <C-o>p

" Highlight all trailing white spaces
set hlsearch
silent! /\s\+$
hi Search ctermbg=DarkGreen
hi Search ctermfg=Blue

" Enable auto indentation
set autoindent

" A funtion for installing Vundle
function InstallVundle()
	PluginInstall
	qa
endfunction

" A function for removing trailing white spaces
function Trailing()
        %s/\s\+$//g
endfunction

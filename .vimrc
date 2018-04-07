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

" A funtion for installing Vundle
function InstallVundle()
	PluginInstall
	qa
endfunction

" A function for removing trailing white spaces
function Trailing()
        %s/\s\+$//ge
endfunction

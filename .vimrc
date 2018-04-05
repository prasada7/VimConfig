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

" Set the character count marker at 80
set cc=80

" Close brackets whenever a open bracket is placed
inoremap {<CR> {<CR><TAB><CR>}<UP><END>

" Enable smart indentation
set smartindent

" A funtion for installing Vundle
function InstallVundle()
		PluginInstall
		qa
endfunction

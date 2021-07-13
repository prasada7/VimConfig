" Map the leader to the comman
let mapleader = ","

" Encoding
set encoding=UTF-8

" Remove the introductory message
set shortmess=I

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

" Encoding
set encoding=UTF-8

set modeline

" Remove the introductory message
set shortmess=I

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

" Use jsx syntax for marko files and mjs files
augroup MarkoJSFileType
    autocmd BufNewFile,BufRead *.\(marko\|mjs\) set filetype=javascript.jsx
augroup END

" Change the way vim splits windows
set splitbelow splitright

" Ignore cases when patern searching
set ignorecase smartcase

" Remove escape key delay
set ttimeoutlen=0

" Enable incremental search and disable gloabal search highlight
set incsearch
set nohlsearch

" Lazy redraw
set lazyredraw

" Set the character count marker at 80
set colorcolumn=+1

" Enable line count with relative line numbers
set number

" Display the status line
set laststatus=2

set showtabline=2 noshowmode

" Customize the tabline
set tabline=%!GetLabel()

" Terminal window size
if has('terminal')
    set termwinsize=15x0
endif

" Set the color scheme
set t_Co=256
set termguicolors
let g:colors_name = 'apprentice' " UPDATE COLORSCHEME NAME HERE

if g:colors_name == 'apprentice'
    color apprentice | color apprentice_ext
elseif g:colors_name == 'seoul256'
    let g:seoul256_background = 233
    color seoul256
    set background=dark
    silent! highlight LineNr ctermbg=233 guibg=#121212
else
    execute "color" . " " . g:colors_name
endif

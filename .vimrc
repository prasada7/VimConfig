" Functions {{{

" A function for removing trailing white spaces
function! Trailing()
    %s/\s\+$//ge
endfunction

" A function for toggling mouse control
function! ToggleMouse()
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
function! GetLabel()
    let s = ''
    let index = 1
    let currentTab = tabpagenr()
    " Loop through all the pages
    while index <= tabpagenr('$')
        let buflist = tabpagebuflist(index)
        let winnr = tabpagewinnr(index)
        let bufname = bufname(buflist[winnr -1])
        let filepath = CompressPath(bufname)
        let filename = fnamemodify(bufname, ':t')
        let isCurrentTab = (index == currentTab ? 1 : 0)
        " Indicate the tab number and determine whether this tab is selected
        let s .= '%' . index . 'T'
        let s .= (isCurrentTab ? '%#TabLineSel#' : '%#TabLine#')

        " Add the file name along with the tab number
        let nameToDisplay = (isCurrentTab ? filename : filepath)
        let s .= ' ' . index . '| ' . (bufname != ''?  nameToDisplay : 'New File' )

        " Add the modifed symbol if the buffer has been modified
        let s .= (getbufvar(index, '&mod') == 1 ? '+ ' : ' ')

        let index += 1
    endwhile

    " Append the tabfill start indication
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

function! CompressPath(filename)
    let filehead = fnamemodify(a:filename, ':h')
    let absolutePath = 0

    " If an absolute path is provided, then remove the first char for now
    if strpart(filehead, 0, 1) == '/'
        let absolutePath = 1
        let filehead = strpart(filehead, 1)
    endif

    " Compress the path
    let filetail = fnamemodify(a:filename, ':t')
    let match = './\+'
    let shortHead = join(map(split(filehead, match), 'strpart(v:val, 0, 1)'), '/')
    let compressedPath = shortHead . '/' . filetail

    " Add back the first character if an absolute path was provided
    let compressedPath = (absolutePath ? '/' . compressedPath : compressedPath)
    return compressedPath
endfunction

" Function to get the path to the snippets file
function! GetSnippets()
    let snippetsFile = "~/.vim/snippets/" . &filetype. ".snippets"
    return snippetsFile
endfunction

" Function to list all snippets for the current filetype in the buffer
function! ListSnippets()
    let snippetsLocation = GetSnippets()
    let listOfSnippets = system("echo ':q! to quit' && cat " . snippetsLocation . " 2>/dev/null")
    vnew | setlocal ft=snippets | put=listOfSnippets
endfunction

" Funtion to edit the snippets file  for the current filetype in the buffer
function! EditSnippets()
    let snippetsLocation = GetSnippets()
    execute "tabe" snippetsLocation
endfunction

" Function to cd into the git root
function! GitRoot()
    let gitRoot = system("git rev-parse --show-toplevel")

    " If the root was found without error, cd into it
    if v:shell_error == 0
        execute "cd" gitRoot
    endif
endfunction

" Function to print and save the full path of the current buffer
function! FullPath()
    let fullPath = expand("%:p")

    " Copy to the clipboard if it exists
    if &clipboard != ""
        let @+ = fullPath
        let @* = fullPath
    endif

    echo expand("%:p")
endfunction

" Function to source the visual configurations
function! SourceVisualConf()
    " Set the color scheme
    set background=dark
    let g:seoul256_background = 233
    let l:apprenticeGreen = 101
    color apprentice

    " Define defaults for the colors
    let l:background = 233                               " Background color
    let l:numberLinebg = 233                             " Line number background color
    let l:currentLinefg = ''                             " Current line number foreground color
    let l:searchbg = ''                                  " Search results highlight color
    let l:trailingbg = ''                                " Trailing spaces highlight color
    let l:currentTabLinebg = ''                          " Active tab background color
    let l:visual = { 'cterm':  '', 'fg': '', 'bg': '' }  " Visual highlight colors
    let l:colorcolbg = 234                               " 80th col highlight color
    let l:gitdiff = {
        \ 'add': { 'cterm':  'none', 'fg': 'none', 'bg': 22 },
        \ 'del': { 'cterm':  'none', 'fg': 'none', 'bg': 95 },
        \ 'change': { 'cterm':  'none', 'fg': 'none', 'bg': 236 },
        \ 'text': { 'cterm':  'bold', 'fg': 'none', 'bg': 52 }
    \ }
    let l:functions = ''

    " Color scheme specific styles
    if g:colors_name == 'apprentice'

        let l:currentLinefg = l:apprenticeGreen
        let l:searchbg = l:apprenticeGreen
        let l:trailingbg = l:apprenticeGreen
        let l:visual = { 'bg': 23, 'fg': 'none','cterm': 'none' }
        let l:functions = 3

    elseif g:colors_name == 'seoul256'

        let l:currentTabLinebg = g:seoul256_background
        let l:numberLinebg = 234

    endif

    " Set the background and foreground configs
    execute printf('silent! highlight Normal ctermbg=%s', l:background)
    execute printf('silent! highlight LineNr ctermbg=%s', l:numberLinebg)
    execute printf('silent! highlight CursorLineNr ctermfg=%s', l:currentLinefg)
    execute printf('silent! highlight ExtraWhitespace ctermbg=%s', l:trailingbg)
    execute printf('silent! highlight Search ctermbg=%s', l:searchbg)
    execute printf('silent! highlight TablineSel ctermbg=%s', l:currentTabLinebg)
    execute printf('silent! highlight ColorColumn ctermbg=%s', l:colorcolbg)
    execute printf('silent! highlight Visual cterm=%s ctermfg=%s ctermbg=%s', l:visual.cterm, l:visual.fg, l:visual.bg)
    execute printf('silent! highlight DiffAdd cterm=%s ctermfg=%s ctermbg=%s', l:gitdiff.add.cterm, l:gitdiff.add.fg, l:gitdiff.add.bg)
    execute printf('silent! highlight DiffChange cterm=%s ctermfg=%s ctermbg=%s', l:gitdiff.change.cterm, l:gitdiff.change.fg, l:gitdiff.change.bg)
    execute printf('silent! highlight DiffDelete cterm=%s ctermfg=%s ctermbg=%s', l:gitdiff.del.cterm, l:gitdiff.del.fg, l:gitdiff.del.bg)
    execute printf('silent! highlight DiffText cterm=%s ctermfg=%s ctermbg=%s', l:gitdiff.text.cterm, l:gitdiff.text.fg, l:gitdiff.text.bg)
    execute printf('silent! highlight Function ctermfg=%s', l:functions)

    " Set the character count marker at 80
    set cc=+1

    " Enable line count with relative line numbers
    set nu rnu

    " Display the status line
    set laststatus=2

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
                \    'filenamebuf': '%{expand("%:h")}[%n]'
                \ },
                \ 'component_function': {
                \    'gitbranch': 'fugitive#head'
                \ }
                \ }
    set showtabline=2 noshowmode

    " Customize the tabline
    set tabline=%!GetLabel()

    " Customize fzf
    let g:fzf_layout = { 'window': 'enew' }

    " NERDTree conf
    let NERDTreeIgnore = ['node_modules']
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI=1

    " Indent line conf
    let g:indentLine_char = '▏'
    let g:indentLine_fileTypeExclude = ['json']
endfunction

" }}}


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
Plugin 'Yggdroot/indentLine'
Plugin 'valloric/matchtagalways'
Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/gv.vim'
Plugin 'alvan/vim-closetag'
Plugin 'jiangmiao/auto-pairs'
Plugin 'romainl/Apprentice'
Plugin 'tpope/vim-dispatch'
Plugin 'w0rp/ale'
Plugin 'neoclide/coc.nvim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'moll/vim-node'
Plugin 'pbogut/fzf-mru.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" }}}


" Functionality {{{

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

" Set folding method for vim files
autocmd FileType vim setlocal foldmethod=marker

" Change the trigger key for Emmet to E instead of Y
let g:user_emmet_leader_key="<C-e>"

" Change emmet user settings
let g:user_emmet_settings = {
\  'jsx' : {
\      'extends' : 'html',
\      'attribute_name': {'class': 'class', 'for': 'for'},
\      'empty_element_suffix': ' />'
\  },
\}

" Use jsx syntax for marko files and mjs files
autocmd BufNewFile,BufRead *.\(marko\|mjs\) set filetype=javascript.jsx

" Map ZZ to lower case to prevent unintentional save and quit
nnoremap ZZ zz

" Change the way vim splits windows
set splitbelow splitright

" Disable ex mode
nmap Q <nop>

" Ignore cases when patern searching
set ignorecase smartcase

" Let matchtagalways work work for javascript.jsx files
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'javascript.jsx' : 1
    \}

" Let tagcomplete work for marko files
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.marko'

" Remove escape key delay
set ttimeoutlen=0

" Enable incremental search and disable gloabal search highlight
set incsearch
set nohlsearch

" Set the coc next key
let g:coc_snippet_next = "<tab>"

" }}}


" Visual configurations {{{

" Edit the function when visuals need to be updated. This is done such that
" the confs can be resourced when NVIM starts. Rerun the visual confs whenver
" the color scheme changes
au ColorScheme * call SourceVisualConf()
call SourceVisualConf()

" }}}


" Custom Mappings {{{
" NORMAL MODE {{{

" Map the leader to the comman
let mapleader = ","

" Map the Nerd tree toggle to F4
nnoremap <F4> :NERDTreeToggle \| setlocal rnu<CR>

" Map to list all custom mappings
nnoremap <Leader>cm :Maps<CR> ~/.vimrc

" Create a command for removing white spaces and map it to F2
command! Trailing execute "call Trailing()"
nnoremap <F2> mt:Trailing<CR>`t

" Map F5 to save the file
nnoremap <F5> :w<CR>

" Map q to quit window and w to write to the file
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

" Map CTRL + P For fuzzy finder
nnoremap <C-p> :FZF<CR>

" Map Alt arrow to moving a line up or down and placing cursor to start/end
nnoremap <M-UP> ddkP
nnoremap <M-DOWN> ddp
map <M-RIGHT> <END>
map <M-LEFT> <HOME>
nnoremap <Leader>b ^
nnoremap <Leader>e $

" Shortcut to replace the word the cursor is on
nnoremap <C-x> ciw
nnoremap <C-d> viw

" CTRL-A for select all
nnoremap <C-a> ggvG$

" Use F3 to toggle mouse control
command! ToggleMouse execute "call ToggleMouse()"
nnoremap <F3> :ToggleMouse<CR>

" Add maps to simplify global search
nnoremap <C-F> :vim //j **/*<left><left><left><left><left><left><left>
nnoremap <F6> :tabe \| cw<CR><C-w>10_

" Fugitive git + fzf shortcuts
nnoremap <Leader>gs :GFiles?<CR>
nnoremap <Leader>gd :Gdiff<CR><C-w>H
nnoremap <Leader>gb :Gblame<CR><C-w>H
nnoremap <Leader>gg :GitGutter<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>:GitGutter<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gf :GFiles<CR>

" Use <F7> to stop highlighting searchs but keep highlighting trailing
nnoremap <F7> mt:noh \| silent! /\s\+$<CR>`t

" Map to list all buffers
nnoremap <Leader>lb :Buffers<CR>

" Map to list history of files
nnoremap <Leader>lh :FZFMru<CR>

" Map to pretty print JSON files
nmap <Leader>pp gqaj

" Map to place all buffers into tabs
nnoremap <Leader>tb :tab ball<CR><CR>

" Map to close file and delete buffer
nnoremap <Leader>cf :bw<CR>

" Map to create a new tab
nnoremap <Leader>nt :tabe<CR>

" Map to locate the current file in NERDTree
nmap <Leader>ff :NERDTreeFind \| setlocal rnu<CR>

" Map to open and source the vimrc file
nmap <Leader>vc :e $MYVIMRC<CR>
nmap <Leader>sc :source $MYVIMRC<CR>

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
nnoremap <S-h> :s///g<left><left><left>

" Map to move the view up and down
nnoremap <Leader>k 5<C-y>
nnoremap <Leader>j 5<C-e>

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
nmap _py :set ft=python<CR>

" Maps to disable the arrow keys
map <LEFT> <nop>
map <UP> <nop>
map <RIGHT> <nop>
map <DOWN> <nop>
imap <LEFT> <nop>
imap <UP> <nop>
imap <RIGHT> <nop>
imap <DOWN> <nop>

" Map to change directory into the current open file
nnoremap <Leader>cd :cd %:p:h<CR>

" Map to run the current file in shell
nnoremap <Leader>rf :!%:p<CR>

" Map to run tasks asynchrously and close
nnoremap <Leader>as :Dispatch

" }}}

" INSERT MODE {{{

" Make shift-tab as outdent
inoremap <S-TAB> <C-d>

" }}}

" VISUAL MODE {{{

" Map Ctrl+x to cut in visual mode
vmap <C-x> ygvx

" Map to global search on the selected text
vmap <Leader>gs y<ESC><C-F><C-R>"<right><right><right>

" }}}

" COMMAND MODE {{{

" Map to set W to save the file instead
cmap W<CR> <ESC><Leader>w

" Abbreviate basic bash commands
cnoreabbrev mkdir !mkdir
cnoreabbrev cp !cp
cnoreabbrev mv !mv
cnoreabbrev rm !rm
cnoreabbrev git !git

" }}}
" }}}


" NeoVim Configurations {{{
if has("nvim")

    " Functionality {{{
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    "" Change the path to the vimrc
    let $MYVIMRC = '~/.vimrc'
    "" Map Exc to return to normal mode in the terminal
    tnoremap <Esc> <C-\><C-n>
    "" Remove linenumbers on terminal open
    autocmd TermOpen * setlocal nonu nornu
    "" Change the mapping of esc when fzf in spawned
    autocmd FileType fzf tmap <ESC> <C-c>
    autocmd BufLeave *
        \ if &ft == 'fzf' |
            \ tnoremap <Esc> <C-\><C-n> |
        \ endif
    " }}}

    " Shortcuts {{{
    nnoremap <C-SPACE> :sp term://bash<CR> \| <C-W>10_ggA
    " }}}

    endif
"}}}


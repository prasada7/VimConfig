" Padmanaban Prasad
" Plugins {{{
" Fetch Plug if it doenst already exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug
call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'
Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-jdaddy'
Plug 'junegunn/seoul256.vim'
Plug 'Yggdroot/indentLine'
if has("python")
    Plug 'valloric/matchtagalways'
endif
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/gv.vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/Apprentice'
Plug 'tpope/vim-dispatch'
Plug 'w0rp/ale'
if executable("node")
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
endif
Plug 'ntpeters/vim-better-whitespace'
Plug 'moll/vim-node'
Plug 'pbogut/fzf-mru.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'jwalton512/vim-blade'
Plug 'ryanoasis/vim-devicons' | Plug 'bryanmylee/vim-colorscheme-icons'

" Neo vim plugins
if has('nvim')
    Plug 'vimlab/split-term.vim'
endif
call plug#end()

" }}}
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

" Function to view all snippets for the current filetype in the buffer
function! ViewSnippets()
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
    execute CopyToClipboard(fullPath)
    echo expand("%:p")
endfunction

" Function to source the visual configurations
function! SourceDynamicVisualConf()
    " Set the color scheme
    set t_Co=256
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
endfunction


" Function and command for opening a terminal
function! Term()
    term ++rows=15
endfunction
if has("terminal")
    command! Term execute "call Term()"
endif

function! CopyToClipboard(...)
    let cursorpos = getcurpos()[1:] " Get the current cursor position to restore it right after
    let textToCopy = get(a:, 1, '')
    let isVisual = get(a:, 2, 0)

    if isVisual && (visualmode() == 'V' || visualmode() == 'v' || visualmode() == "\<CTRL-v>")
        silent normal! gv"yy
        let textToCopy = getreg('y')
    endif
    if executable("clip.exe")
        execute system("echo " . "'" . textToCopy . "' | clip.exe")
    endif

    " Add the text to the appropriate registers
    if &clipboard != ""
        execute setreg("*", textToCopy)
        execute setreg("+", textToCopy)
    endif
    call cursor(cursorpos) " setreg() seems to jump the cursor up to the top for some reason
endfunction

" }}}
" Functionality {{{
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

" Set folding method for vim files
augroup VimFold
    autocmd FileType vim setlocal foldmethod=marker
augroup END

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
augroup MarkoJSFileType
    autocmd BufNewFile,BufRead *.\(marko\|mjs\) set filetype=javascript.jsx
augroup END

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

" Ctrl p
let g:ctrlp_show_hidden = 1

" Lazy redraw
set lazyredraw

" Use legacy parser for snipmate extension
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['blade'] = 'blade,javascript.jsx,php'
let g:snipMate.snippet_version = 1

" Disable ALE on insert (Causes multi cursor to lag)
function! Multiple_cursors_before()
    if exists(":ALEDisable")==2
        exe 'ALEDisable'
    endif
    if exists(":CocDisable")==2
        exe 'CocDisable'
    endif
endfunction
function! Multiple_cursors_after()
    if exists(":ALEEnable")==2
        exe 'ALEEnable'
    endif
    if exists(":CocEnable")==2
        exe 'CocEnable'
    endif
endfunction

" Change shortcut to move through hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" }}}
" Visual configurations {{{
" Edit the function when visuals need to be updated. This is done such that
" the confs can be resourced when NVIM starts. Rerun the visual confs whenever
" the color scheme changes
au ColorScheme * call SourceDynamicVisualConf()
silent! call SourceDynamicVisualConf()

" Set the character count marker at 80
set colorcolumn=+1

" Enable line count with relative line numbers
set number

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
            \ },
            \ 'colorscheme': 'apprentice'
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

" }}}
" Custom Mappings {{{
" NORMAL MODE {{{

" Map the leader to the comman
let mapleader = ","

" Map the Nerd tree toggle to F4
nnoremap <F4> :NERDTreeToggle \| setlocal number<CR>

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
nmap <Leader>ff :NERDTreeFind \| setlocal number<CR>

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

" Maps to disable the arrow keys COMMENTED OUT TO NOT FREAK OUT PEOPLE :(
" map <LEFT> <nop>
" map <UP> <nop>
" map <RIGHT> <nop>
" map <DOWN> <nop>
" imap <LEFT> <nop>
" imap <UP> <nop>
" imap <RIGHT> <nop>
" imap <DOWN> <nop>

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

    " Change the path to the vimrc
    let $MYVIMRC = '~/.vim/.vimrc'

    " Map Exc to return to normal mode in the terminal
    tnoremap <Esc> <C-\><C-n>

    " Override the default terminal command to use extension
    cnoreabbrev term Term

    " Remove linenumbers on terminal open
    augroup NVIMSPECIFIC
        autocmd TermOpen * setlocal nonu
        " Change the mapping of esc when fzf in spawned
        autocmd FileType fzf tmap <ESC> <C-c>
        autocmd BufLeave *
                    \ if &ft == 'fzf' |
                    \ tnoremap <Esc> <C-\><C-n> |
                    \ endif
    augroup END
    " }}}

    endif
"}}}

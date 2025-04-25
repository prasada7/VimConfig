" Fetch Plug if it doenst already exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'mg979/vim-visual-multi'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
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
Plug 'w0rp/ale'
if executable("node")
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
endif
Plug 'ntpeters/vim-better-whitespace'
Plug 'moll/vim-node'
Plug 'pbogut/fzf-mru.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'ryanoasis/vim-devicons' | Plug 'bryanmylee/vim-colorscheme-icons'
Plug 'arcticicestudio/nord-vim'
Plug 'prasada7/toggleterm.vim'
Plug 'sheerun/vim-polyglot'

" Neo vim plugins
if has('nvim')
    Plug 'vimlab/split-term.vim'
endif
call plug#end()

" Plugin specifc configurations

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

" Let matchtagalways work work for javascript.jsx files
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'javascript.jsx' : 1,
    \ 'blade' : 1
    \}

" File types where closetags should work
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.marko,*.blade.php'

" Set the coc next key
let g:coc_snippet_next = "<tab>"

" Snipmate configuration
" Use legacy parser for snipmate extension
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['blade'] = 'blade,javascript.jsx,php'
let g:snipMate.snippet_version = 1
imap <C-J> <Plug>snipMateNextOrTrigger

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

" Ale configurations
let g:ale_php_phpcs_standard = 'PSR2'

" Customize the status line
" NOTE: Change colorscheme if supported by lightline
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
            \ 'colorscheme': 'nord'
            \ }

" Customize fzf
let g:fzf_layout = { 'window': 'new' }

" NERDTree conf
let NERDTreeIgnore = ['node_modules']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" Indent line conf
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['json']

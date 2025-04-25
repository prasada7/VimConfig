" vim: foldmethod=marker
" Padmanaban Prasad
" Source necessary config files {{{
runtime ~/.vim plugins.vim
runtime ~/.vim general.vim
runtime ~/.vim functions.vim
runtime ~/.vim cocconfig.vim

" }}}
" Custom Mappings {{{

" NORMAL MODE {{{

" Disable ex mode
nmap Q <nop>

" Map ZZ to lower case to prevent unintentional save and quit
nnoremap ZZ zz

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

" CTRL-A for select all
nnoremap <C-a> ggvG$

" Use F3 to toggle mouse control
command! ToggleMouse execute "call ToggleMouse()"
nnoremap <F3> :ToggleMouse<CR>

" Fugitive git + fzf shortcuts
nnoremap <Leader>gs :GFiles?<CR>
nnoremap <Leader>gd :Gdiff<CR><C-w>H
nnoremap <Leader>gb :Gblame<CR><C-w>H
nnoremap <Leader>gg :GitGutter<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>:GitGutter<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gf :GFiles<CR>

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

" Map to change directory into the current open file
nnoremap <Leader>cd :cd %:p:h<CR>

" Map to run the current file in shell
nnoremap <Leader>rf :!%:p<CR>

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

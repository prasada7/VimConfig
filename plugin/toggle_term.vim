" Toggle Term
" Last Change:	2021 Jul 17
" Maintainer:	Anandha Padmanaban Prasad <padmanabam_789@hotmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_toggle_term") || !has("terminal")
  finish
endif
let g:loaded_toggle_term = 1

let s:save_cpo = &cpo
set cpo&vim

if !hasmapto('<Plug>ToggletermToggle')
    nmap <silent> <C-Bslash> <Plug>ToggletermToggle
    tmap <silent> <C-Bslash> <C-w><S-N><Plug>ToggletermToggle
endif
noremap <silent> <script> <Plug>ToggletermToggle  <SID>Toggle
noremap <silent> <script> <SID>Toggle  :call <SID>Toggle()<CR>

" Constants
let s:term_name = "toggle_term"

" Customizations
let s:toggle_term_height = get(g:, "toggle_term_height", 15)

" Toggle Term
function s:Toggle()
    let l:buf_info = getbufinfo(s:term_name)
    let l:toggle_nerd_tree = 0
    let l:prev_position = getcurpos()

    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        execute "NERDTreeToggle"
        let l:toggle_nerd_tree = 1
    endif

    if !bufexists(s:term_name)
        botright call term_start(&shell, {"term_name": s:term_name, "term_finish": "close", "term_kill": "kill"})
    elseif l:buf_info[0].hidden
        botright new
        execute "resize " . s:toggle_term_height
        execute "buffer " . bufnr(s:term_name)
        silent normal A
    elseif !l:buf_info[0].hidden
        call s:Focus()
        wincmd N | hide
        call setpos('.', l:prev_position)
    endif

    if exists("g:NERDTree") && l:toggle_nerd_tree == 1
        execute "NERDTreeToggle"
    endif

    call s:Focus()
endfunction

function s:Focus()
    let l:winid = bufwinid(s:term_name)

    if l:winid != -1
        execute "call win_gotoid(" . l:winid . ")"
    endif
endfunction


if !exists(":Toggleterm")
  command Toggleterm  :call s:Toggle()
endif

let &cpo = s:save_cpo
unlet s:save_cpo


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
    let l:toggle_nerd_tree = 0
    let l:term_hidden = s:IsHidden()

    if !bufexists(s:term_name)
        call s:GoToLastWindow()
        rightbelow call term_start(&shell, {"term_name": s:term_name, "term_finish": "close", "term_kill": "kill"})
    elseif l:term_hidden
        " Position the terminal right below the very last window
        call s:GoToLastWindow()
        rightbelow new
        execute "resize " . s:toggle_term_height
        execute "buffer " . bufnr(s:term_name)

        " Make sure we do not get any errors when trying to go to insert mode
        if mode() == 'n'
            silent normal A
        endif
    elseif !l:term_hidden
        call s:Focus()
        wincmd N | hide
    endif
endfunction

" Move cursor to the toggle terminal's buffer
function s:Focus()
    let l:winid = bufwinid(s:term_name)
    if l:winid != -1
        execute "call win_gotoid(" . l:winid . ")"
    endif
endfunction

function s:GoToLastWindow()
    let l:last_win_id = win_getid(winnr('$'))
    execute "call win_gotoid(" . l:last_win_id . ")"
endfunction

function s:IsHidden()
    let l:currentTab = tabpagenr()

    for l:bId in tabpagebuflist(currentTab)
        if bufname(l:bId) == s:term_name
            return 0
        endif
    endfor

    return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo


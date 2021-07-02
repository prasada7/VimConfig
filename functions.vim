" Remove trailing white spaces
function Trailing()
    %s/\s\+$//ge
endfunction

" Toggle mouse control
function ToggleMouse()
    " Check if mouse is set and toggle accordingly
    if &mouse == 'a'
        set mouse=
        echo "mouse disabled"
    else
        set mouse=a
        echo "mouse enabled"
    endif
endfunction

" Create the label for the tabline
function GetLabel()
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
        let s .= (getbufvar(bufname, '&mod') == 1 ? '+ ' : ' ')

        let index += 1
    endwhile

    " Append the tabfill start indication
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

function CompressPath(filename)
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

" Get the path to the snippets file
function GetSnippets()
    let snippetsFile = "~/.vim/snippets/" . &filetype. ".snippets"
    return snippetsFile
endfunction

" View all snippets for the current filetype in the buffer
function ViewSnippets()
    let snippetsLocation = GetSnippets()
    let listOfSnippets = system("echo ':q! to quit' && cat " . snippetsLocation . " 2>/dev/null")
    vnew | setlocal ft=snippets | put=listOfSnippets
endfunction

" Edit the snippets file  for the current filetype in the buffer
function EditSnippets()
    let snippetsLocation = GetSnippets()
    execute "tabe" snippetsLocation
endfunction

" Change directory into the root of git repo
function GitRoot()
    let gitRoot = system("git rev-parse --show-toplevel")

    " If the root was found without error, cd into it
    if v:shell_error == 0
        execute "cd" gitRoot
    endif
endfunction

" Print and save the full path of the current buffer
function FullPath()
    let fullPath = expand("%:p")
    execute CopyToClipboard(fullPath)
    echo expand("%:p")
endfunction

" Terminal with set height
function Term()
    term ++rows=15
endfunction
if has("terminal")
    command! Term execute "call Term()"
endif

" Copy to system clipboard (WSL)
function CopyToClipboard(...)
    let cursorpos = getcurpos()[1:] " Get the current cursor position to restore it right after
    let textToCopy = get(a:, 1, '')
    let isVisual = get(a:, 2, 0)

    if isVisual && (visualmode() == 'V' || visualmode() == 'v' || visualmode() == "\<CTRL-v>")
        silent normal! gv"yy
        let textToCopy = getreg('y')
    endif
    if executable("clip.exe")
        execute system("printf " . "'" . textToCopy . "' | clip.exe")
    endif

    " Add the text to the appropriate registers
    if &clipboard != ""
        execute setreg("*", textToCopy)
        execute setreg("+", textToCopy)
    endif
    call cursor(cursorpos) " setreg() seems to jump the cursor up to the top for some reason
endfunction

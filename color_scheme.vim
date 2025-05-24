" Set the color scheme
set t_Co=256
set termguicolors
let g:colors_name = g:color_scheme

if g:colors_name == 'apprentice'
    color apprentice | color apprentice_ext
else
    execute "color" . " " . g:colors_name
endif

"" Theme OneDark
if filereadable(expand("~/.local/share/nvim/plugged/onedark.vim/colors/onedark.vim"))
    colorscheme onedark
    set cursorline
    set termguicolors
endif

"" Theme OneDark Lightline
if filereadable(expand("~/.local/share/nvim/plugged/lightline.vim/autoload/lightline.vim"))
    let g:lightline = { 'colorscheme': 'onedark', }
    set noshowmode
endif

"" Theme OneDark Airline
if filereadable(expand("/usr/share/vim-airline/autoload/airline.vim"))
    let g:airline_theme='onedark'
    set noshowmode
endif

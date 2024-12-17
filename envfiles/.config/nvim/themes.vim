"" Theme OneDark
if filereadable(expand("~/.local/share/nvim/plugged/onedark.vim/colors/onedark.vim"))
  let g:onedark_hide_endofbuffer = 1
  "let g:onedark_terminal_italics = 1
  colorscheme onedark
  set cursorline
  set termguicolors
endif

"" Theme OneDark Lightline
if filereadable(expand("~/.local/share/nvim/plugged/lightline.vim/autoload/lightline.vim"))
  let g:lightline = { 'colorscheme': 'onedark' , }
  set noshowmode
endif

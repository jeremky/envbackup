"" Téléchargement de vim-plug si introuvable
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Lance automatiquement PlugInstall
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

"" Liste des plugins
call plug#begin()

"Theme
Plug 'joshdick/onedark.vim'

" Interface
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'

"Code
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'

" Completion
Plug 'ervandew/supertab'
Plug 'vim-scripts/VimCompletesMe'

"Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()


"" Configuration du thème OneDark
if filereadable(expand("~/.local/share/nvim/plugged/onedark.vim/colors/onedark.vim"))
  let g:onedark_hide_endofbuffer = 1
  let g:onedark_terminal_italics = 0
  colorscheme onedark
  set cursorline
  set termguicolors
endif

"" Configuration de lightline
if filereadable(expand("~/.local/share/nvim/plugged/lightline.vim/autoload/lightline.vim"))
  set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
  let g:lightline = { 'colorscheme': 'onedark' , }
  set noshowmode
endif

"" Configuration de nerdtree
if filereadable(expand("~/.local/share/nvim/plugged/nerdtree/autoload/nerdtree.vim"))
  set modifiable
  nnoremap <C-o> :NERDTreeToggle <CR>
  nnoremap <F1> :NERDTreeToggle <CR>
  let NERDTreeMapOpenInTab='<TAB>'
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
endif

"" Configuration de VimCompletesMe
if filereadable(expand("~/.local/share/nvim/plugged/VimCompletesMe/plugin/VimCompletesMe.vim"))
  autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
endif

"" Configuration de gitgutter
if filereadable(expand("~/.local/share/nvim/plugged/vim-gitgutter/autoload/gitgutter.vim"))
  nnoremap <C-g> :GitGutterToggle <CR>
  let gitgutter_enabled = 0
endif

"" Configuration de indentLine
if filereadable(expand("~/.local/share/nvim/plugged/indentLine/after/plugin/indentLine.vim"))
  let g:indentLine_enabled = 0
  let g:indentLine_char = '▏'
endif

"" Mode IDE
nnoremap <F2> :call ModeIDE() <CR>
function! ModeIDE()
  set number!
  IndentLinesToggle
  GitGutterToggle
endfunction

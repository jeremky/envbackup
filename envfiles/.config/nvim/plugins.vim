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


"" Configuration de nerdtree
if filereadable(expand("~/.local/share/nvim/plugged/nerdtree/autoload/nerdtree.vim"))
  set modifiable
  autocmd vimenter * if !argc() | NERDTree | endif
  nnoremap <C-o> :NERDTreeToggle <CR>
  nnoremap <F1> :NERDTreeToggle <CR>
  let NERDTreeMapOpenInTab='<TAB>'
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
endif

"" Configuration de gitgutter
if filereadable(expand("~/.local/share/nvim/plugged/vim-gitgutter/autoload/gitgutter.vim"))
  nnoremap <C-g> :GitGutterToggle <CR>
  let gitgutter_enabled = 0
endif

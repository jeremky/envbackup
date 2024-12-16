"" Téléchargement de vim-plug si introuvable
if empty(glob('~/.config/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/.nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"" Liste des plugins
call plug#begin()

"Plug 'tpope/vim-sensible'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'vim-scripts/VimCompletesMe'
Plug 'airblade/vim-gitgutter'

call plug#end()

"" Chargement des plugins apt
"if filereadable(expand("/usr/share/vim-youcompleteme/plugin/youcompleteme.vim"))
"  packadd! youcompleteme
"endif

"" Configuration de nerdtree
if filereadable(expand("~/.local/share/nvim/plugged/nerdtree/autoload/nerdtree.vim"))
  nnoremap <C-o> :NERDTreeToggle <CR>
  let NERDTreeMapOpenInTab='<TAB>'
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
endif

"" Configuration de gitgutter
if filereadable(expand("~/.local/share/nvim/plugged/vim-gitgutter/autoload/gitgutter.vim"))
  nnoremap <C-g> :GitGutterToggle <CR>
  let gitgutter_enabled = 0
endif

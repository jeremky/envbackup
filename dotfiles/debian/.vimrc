"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration de vim

" Paramétrage de base
syntax on                       " Active la colorisation syntaxique
set nocompatible                " Désactive la compatibilité Vi
set ttimeoutlen=10              " Désactive le timeout de changement de mode
set hlsearch                    " Affiche en surbrillance les recherches
set background=dark             " Optimise l'affiche pour un terminal sombre
set smartindent                 " Indentation intelligente
set smarttab                    " Gestion des espaces en début de ligne
set autoindent                  " Conserve l'indentation sur une nouvelle ligne
set ruler                       " Affiche la position du curseur
set tabstop=2                   " La largeur d'une tabulation est définie sur 2
set shiftwidth=2                " Les retraits auront une largeur de 2
set softtabstop=2               " Nombre de colonnes pour une tabulation
set expandtab                   " Remplace les tab par des espaces
set linebreak                   " Revient à la ligne sans couper les mots
set showcmd                     " Afficher la commande dans la ligne d'état
set showmatch                   " Afficher les parenthèses correspondantes
set ignorecase                  " Ignorer la casse
set smartcase                   " Faire un appariement intelligent
set incsearch                   " Recherche incrémentielle
set hidden                      " Cacher les tampons lorsqu'ils sont abandonnés
set mouse=                      " Désactive la souris par défaut
set clipboard=unnamedplus       " Paramètre le clipboard si compatible
set nobackup                    " Désactive les sauvegardes automatiques
set spelllang=fr,en             " Spécifie les langues du dictionnaire
set viminfofile=~/.vim/.viminfo " Change l'emplacement du fichier viminfo

" Permet l'indentation automatique : gg=G
filetype plugin indent on

" Definition des caractères invisibles
let &listchars = "eol:$,space:\u00B7"

" Changement automatique du curseur en fonction du mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Mémoriser la dernière position du curseur
autocmd BufReadPost * if (line("'\"") > 1) && (line("'\"") <= line("$")) | silent exe "silent! normal g'\"zO" | endif

" Désactivation des # au retour chariot
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fonctions

" Souris
function! MouseToggle()
  if &mouse == 'a'
    set mouse=
    echo "Souris désactivée"
  else
    set mouse=a
    echo "Souris activée"
  endif
endfunction

" Mode IDE
function! ModeIDE()
  set number!
  IndentLinesToggle
  GitGutterToggle
  call MouseToggle()
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping

" Nerdtree
nnoremap <F1> <Cmd>NERDTreeToggle<CR>

" Mode IDE
nnoremap <F2> <Cmd>call ModeIDE()<CR>

" Correction orthographique (z= pour afficher les propositions)
nnoremap <F3> <Cmd>set spell!<CR>

" Affichage des caractères invisibles
nnoremap <F4> <Cmd>set list!<CR>

" Indentation automatique
nnoremap <F5> gg=G <CR>

" Commentaire
nnoremap <F6> <Plug>CommentaryLine
xnoremap <F6> <Plug>Commentary

" Alignement automatique
nnoremap <F7> <Plug>(EasyAlign)
xnoremap <F7> <Plug>(EasyAlign)

" MAJ des plugins
nnoremap <F8> <Cmd>PlugUpdate<CR>

" Changement de document
nnoremap <TAB> <Cmd>tabnext<CR>
nnoremap <S-TAB> <C-W>w

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

" Téléchargement de vim-plug si introuvable
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Lance automatiquement PlugInstall
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

" Liste des plugins
call plug#begin()

" Theme
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Interface
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'

" Code
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'

" Completion
Plug 'ervandew/supertab'
Plug 'vim-scripts/VimCompletesMe'

call plug#end()


" Configuration du theme Catppuccin
if filereadable(expand("~/.vim/plugged/catppuccin/colors/catppuccin_macchiato.vim"))
  colorscheme catppuccin_macchiato
  set cursorline
  set termguicolors
endif

" Configuration de LightLine
if filereadable(expand("~/.vim/plugged/lightline.vim/autoload/lightline.vim"))
  let g:lightline = {'colorscheme': 'catppuccin_macchiato'}
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '', 'right': '' }
  set laststatus=2
  set noshowmode
endif

" Configuration de NERDTree
if filereadable(expand("~/.vim/plugged/nerdtree/autoload/nerdtree.vim"))
  set modifiable
  let NERDTreeMapOpenInTab='<TAB>'
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
endif

" Configuration de IndentLine
if filereadable(expand("~/.vim/plugged/indentLine/after/plugin/indentLine.vim"))
  let g:indentLine_enabled = 0
  let g:indentLine_char = '▏'
endif

" Configuration de GitGutter
if filereadable(expand("~/.vim/plugged/vim-gitgutter/autoload/gitgutter.vim"))
  let gitgutter_enabled = 0
endif

" Configuration de AutoPairs
if filereadable(expand("~/.vim/plugged/auto-pairs/plugin/auto-pairs.vim"))
  let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'"}
endif

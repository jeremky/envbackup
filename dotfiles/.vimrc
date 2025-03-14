""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration de Vim

" Ne pas charger le fichier par defaut
let g:skip_defaults_vim = 1

" Parametrage de base
syntax on                       " Active la colorisation syntaxique
set hlsearch                    " Affiche en surbrillance les recherches
set background=dark             " Optimise l'affiche pour un terminal sombre
set laststatus=2                " Affiche en permanence la barre de statut
set smartindent                 " Indentation intelligente
set smarttab                    " Gestion des espaces en debut de ligne
set autoindent                  " Conserve l'indentation sur une nouvelle ligne
set ruler                       " Affiche la position du curseur
set tabstop=2                   " La largeur d'une tabulation est definie sur 2
set shiftwidth=2                " Les retraits auront une largeur de 2
set softtabstop=2               " Nombre de colonnes pour une tabulation
set expandtab                   " Remplace les tab par des espaces
set linebreak                   " Revient à la ligne sans couper les mots
set showcmd                     " Afficher la commande dans la ligne d'etat
set showmatch                   " Afficher les parentheses correspondantes
set ignorecase                  " Ignorer la casse
set smartcase                   " Faire un appariement intelligent
set incsearch                   " Recherche incrementielle
set hidden                      " Cacher les tampons lorsqu'ils sont abandonnes
set mouse=                      " Desactive la souris par defaut
set nobackup                    " Desactive les sauvegardes automatiques
set spelllang=fr,en             " Specifie les langues du dictionnaire

" Permet l'indentation automatique : gg=G
filetype plugin indent on

" Definition des caracteres invisibles
let &listchars = "eol:$,space:\u00B7"

" Changement automatique du curseur en fonction du mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fermeture automatique des brackets
inoremap { {}<Esc>ha
inoremap [ []<Esc>ha

" Memoriser la derniere position du curseur
autocmd BufReadPost * if (line("'\"") > 1) && (line("'\"") <= line("$")) | silent exe "silent! normal g'\"zO" | endif

" Modification de certaines syntaxes
autocmd BufNewFile,BufRead *.lpl set syntax=json

" Configuration pour tmux
if $TERM == 'tmux-256color'
  set clipboard=unnamedplus
  set mouse=a
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping

" Nerdtree
nnoremap <F1> :NERDTreeToggle <CR>

" Mode IDE
nnoremap <F2> :call ModeIDE() <CR>
function! ModeIDE()
  set number!
  IndentLinesToggle
  GitGutterToggle
endfunction

" Correction orthographique (z= pour afficher les propositions)
map <F3> :set spell!<CR>

" Coloration syntaxique
nnoremap <F4> :call ToggleSyntax()<CR>
function! ToggleSyntax()
  if &syntax == ''
    syntax on
    echo "Coloration syntaxique activee"
  else
    syntax off
    set syntax=
    echo "Coloration syntaxique desactivee"
  endif
endfunction

" Indentation automatique
nnoremap <F5> gg=G <CR>

" Souris
nnoremap <F6> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Souris desactivee"
  else
    set mouse=a
    echo "Souris activee"
  endif
endfunction

" Affichage des caracteres invisibles
nnoremap <F7> :set list!<CR>

" Changement de document
nnoremap <S-TAB> <C-W>w
nnoremap <TAB> :tabnext<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

" Telechargement de vim-plug si introuvable
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
"Plug 'joshdick/onedark.vim'

" Interface
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'

" Code
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'

" Completion
Plug 'ervandew/supertab'
Plug 'vim-scripts/VimCompletesMe'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()


" Configuration du theme OneDark
"if filereadable(expand("~/.vim/plugged/onedark.vim/colors/onedark.vim"))
"  let g:onedark_hide_endofbuffer = 1
"  let g:onedark_terminal_italics = 0
"  colorscheme onedark
"  set cursorline
"  set termguicolors
"endif

" Configuration du theme Catppuccin
if filereadable(expand("~/.vim/plugged/catppuccin/colors/catppuccin_macchiato.vim"))
  colorscheme catppuccin_macchiato
  set cursorline
  set termguicolors
endif

" Configuration de LightLine
if filereadable(expand("~/.vim/plugged/lightline.vim/autoload/lightline.vim"))
  set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
  let g:lightline = { 'colorscheme': 'catppuccin_macchiato' , }
  set noshowmode
endif

" Configuration de NERDTree
if filereadable(expand("~/.vim/plugged/nerdtree/autoload/nerdtree.vim"))
  set modifiable
  nnoremap <C-o> :NERDTreeToggle <CR>
  let NERDTreeMapOpenInTab='<TAB>'
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
endif

" Configuration de IndentLine
if filereadable(expand("~/.vim/plugged/indentLine/after/plugin/indentLine.vim"))
  let g:indentLine_enabled = 0
  let g:indentLine_char = '▏'
endif

" Configuration de VimCompletesMe
if filereadable(expand("~/.vim/plugged/VimCompletesMe/plugin/VimCompletesMe.vim"))
  autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
endif

" Configuration de GitGutter
if filereadable(expand("~/.vim/plugged/vim-gitgutter/autoload/gitgutter.vim"))
  nnoremap <C-g> :GitGutterToggle <CR>
  let gitgutter_enabled = 0
endif

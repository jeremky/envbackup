""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings

" Paramétrage de base
syntax on                       " Active la colorisation syntaxique
set hlsearch                    " Affiche en surbrillance les recherches
set background=dark             " Optimise l'affiche pour un terminal sombre
set laststatus=2                " Affiche en permanence la barre de status
set smartindent                 " Indentation intelligente
set smarttab                    " Gestion des espaces en début de ligne
set autoindent                  " Conserve l'indentation sur une nouvelle ligne
set ruler                       " Affiche la position du curseur
set tabstop=2                   " La largeur d'une tabulation est définie sur 2
set shiftwidth=2                " Les retraits auront une largeur de 2
set softtabstop=2               " Nombre de colonnes pour une tabulation
set expandtab                   " Remplace les tab par des espaces
set linebreak                   " Revient à la ligne sans couper les mots
set showcmd                     " Afficher la commande dans la ligne d'etat
set showmatch                   " Afficher les parentheses correspondantes
set ignorecase                  " Ignorer la casse
set smartcase                   " Faire un appariement intelligent
set incsearch                   " Recherche incrémentielle
set hidden                      " Cacher les tampons lorsqu'ils sont abandonnes
set mouse=                      " Désactive la souris par défaut
set nobackup                    " Désactive les sauvegardes automatiques
set spelllang=fr,en             " Spécifie les langues du dictionnaire

" Permet l'indentation automatique : gg=G
filetype plugin indent on

" Définition des caractères invisibles
let &listchars = "eol:$,space:\u00B7"

"" Changement automatique du curseur en fonction du mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fermeture automatique des brackets
inoremap { {}<Esc>ha
inoremap [ []<Esc>ha

" Mémoriser la dernière position du curseur
autocmd BufReadPost * if (line("'\"") > 1) && (line("'\"") <= line("$")) | silent exe "silent! normal g'\"zO" | endif

" Modification de certaines syntaxes
autocmd BufNewFile,BufRead *.lpl set syntax=json

" Configuration pour tmux
if $TERM == 'tmux-256color'
  set clipboard=unnamedplus
  set mouse=a
endif

"" Explorateur de fichiers
let g:netrw_liststyle = 3         " Active le mode Treeview
let g:netrw_sizestyle = "H"       " Active le mode human-readable
let g:netrw_banner = 0            " Désactive la bannière
let g:netrw_browse_split = 4      " Ouvre le fichier choisi dans un panel
let g:netrw_altv = 1              " Ouvre en mode vertical
let g:netrw_winsize = 15          " Définit la taille de l'explorateur

"" Ferme automatiquement l'explorateur
aug netrw_close
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
aug END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping

" Explorateur de fichiers
nnoremap <F1> :Vexplore<CR>

"" Activation de la numérotation
nnoremap <F2> :set number!<CR>

" Correction orthographique (z= pour afficher les propositions)
map <F3> :set spell!<CR>

" Coloration syntaxique
nnoremap <F4> :call ToggleSyntax()<CR>
function! ToggleSyntax()
  if &syntax == ''
    syntax on
    echo "Coloration syntaxique activée"
  else
    syntax off
    set syntax=
    echo "Coloration syntaxique désactivée"
  endif
endfunction

" Indentation automatique
nnoremap <F5> gg=G <CR>

" Souris
nnoremap <F6> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Souris désactivée"
  else
    set mouse=a
    echo "Souris activée"
  endif
endfunction

" Affichage des caractères invisibles
nnoremap <F7> :set list!<CR>

" Changement d'onglet ou de document
nnoremap <TAB> :tabnext<CR>
nnoremap <S-TAB> <C-W>w


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme

" OneHalfDark
if filereadable(expand("~/.vim/colors/onehalfdark.vim"))
  set cursorline
  set t_Co=256
  colorscheme onehalfdark
  set termguicolors
  if filereadable(expand("/usr/share/vim-airline/plugin/airline.vim"))
    let g:airline_theme='onedark'
    set noshowmode
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

"" YouCompleteMe
if filereadable(expand("/usr/share/vim-youcompleteme/plugin/youcompleteme.vim"))
  packadd! youcompleteme
endif

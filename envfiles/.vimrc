"" Paramétrage des couleurs
syntax on                       " Active la colorisation syntaxique
set hlsearch                    " Affiche en surbrillance les recherches
set background=dark             " Optimise l'affiche pour un terminal sombre

"" Paramétrage d'affichage
set nocompatible                " Utilisation de Vim par défaut
set smartindent                 " Indentation intelligente
set smarttab                    " Gestion des espaces en début de ligne
set autoindent                  " Conserve l'indentation sur une nouvelle ligne
set ruler                       " Affiche la position du curseur
set tabstop=4                   " La largeur d'une tabulation est définie sur 4
set shiftwidth=4                " Les retraits auront une largeur de 4
set softtabstop=4               " Nombre de colonnes pour une tabulation
set expandtab                   " Remplace les tab par des espaces
set linebreak                   " Revient à la ligne sans couper les mots

filetype plugin indent on       " Permet l'indentation automatique : gg=G

"" Paramètres supplémentaires
set showcmd                     " Afficher la commande dans la ligne d'etat
set showmatch                   " Afficher les parentheses correspondantes
set ignorecase                  " Ignorer la casse
set smartcase                   " Faire un appariement intelligent
set incsearch                   " Recherche incrémentielle
set hidden                      " Cacher les tampons lorsqu'ils sont abandonnes
set mouse=                      " Désactive la souris par défaut
set nobackup                    " Désactive les sauvegardes automatiques

"" Explorateur de fichiers
let g:netrw_liststyle = 3       " Active le mode Treeview
let g:netrw_sizestyle = "H"     " Active le mode human-readable
let g:netrw_banner = 0          " Désactive la bannière
let g:netrw_browse_split = 4    " Ouvre le fichier choisi dans un panel
let g:netrw_altv = 1            " Ouvre en mode vertical
let g:netrw_winsize = 15        " Définit la taille de l'explorateur

"" Ferme automatiquement l'explorateur
aug netrw_close
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
aug END

"" Mémoriser la dernière position du curseur
autocmd BufReadPost * if (line("'\"") > 1) && (line("'\"") <= line("$")) | silent exe "silent! normal g'\"zO" | endif

" Explorateur de fichiers
nnoremap <F1> :Vexplore <CR>

"" Correction orthographique (z= pour afficher les propositions)
map <F2> :set spell!<CR>
set spelllang=fr,en
hi SpellBad ctermfg=Red ctermbg=NONE

"" Activation de la numérotation
nnoremap <F3> :set number!<CR>

"" Coloration syntaxique
nnoremap <F4> :call ToggleSyntax()<CR>
function! ToggleSyntax()
    if &syntax == ''
        syntax on
        echo "Syntax enabled"
    else
        syntax off
        set syntax=
        echo "Syntax disabled"
    endif
endfunction

"" Indentation automatique
nnoremap <F5> gg=G <CR>

"" Souris
nnoremap <F6> :call ToggleMouse()<CR>
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse usage disabled"
    else
        set mouse=a
        echo "Mouse usage enabled"
    endif
endfunction

"" Affichage des caractères en fin de ligne
nnoremap <F7> :set list!<CR>

"" Ajout du theme OneHalfDark
if filereadable(expand("~/.vim/colors/onehalfdark.vim")) && $TERM == 'xterm-256color'
    set cursorline
    colorscheme onehalfdark
    set termguicolors
endif

"" Ajout de la syntaxe pour des extensions précises
autocmd BufNewFile,BufRead *.txt set syntax=cfg
autocmd BufNewFile,BufRead *.lpl set syntax=json

"" Chargement des plugins
if filereadable(expand("/usr/share/vim-youcompleteme/plugin/youcompleteme.vim"))
    packadd! youcompleteme
endif

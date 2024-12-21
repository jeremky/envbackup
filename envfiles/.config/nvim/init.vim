"" Paramétrage de base
set tabstop=2                   " La largeur d'une tabulation est définie sur 2
set shiftwidth=2                " Les retraits auront une largeur de 2
set softtabstop=2               " Nombre de colonnes pour une tabulation
set expandtab                   " Remplace les tab par des espaces
set linebreak                   " Revient à la ligne sans couper les mots
set showmatch                   " Afficher les parentheses correspondantes
set ignorecase                  " Ignorer la casse
set smartcase                   " Faire un appariement intelligent

"" Définition des caractères invisibles
let &listchars = "eol:$,space:\u00B7"

"" Fermeture automatique des brackets
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap ' ''<Esc>ha

"" Mémoriser la dernière position du curseur
autocmd BufReadPost * if (line("'\"") > 1) && (line("'\"") <= line("$")) | silent exe "silent! normal g'\"zO" | endif

"" Modification de certaines syntaxes
autocmd BufNewFile,BufRead *.txt set syntax=cfg
autocmd BufNewFile,BufRead *.lpl set syntax=json

"" Configuration pour tmux
if $TERM == 'tmux-256color'
  set clipboard=unnamedplus
  set mouse=a
endif

"" Activation de la numérotation
nnoremap <F2> :set number!<CR>

"" Correction orthographique (z= pour afficher les propositions)
map <F3> :set spell!<CR>
set spelllang=fr,en
hi SpellBad ctermfg=Red ctermbg=NONE

"" Coloration syntaxique
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

"" Indentation automatique
nnoremap <F5> gg=G <CR>

"" Souris
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

"" Affichage des caractères en fin de ligne
nnoremap <F7> :set list!<CR>

"" Changement d'onglet ou de document
nnoremap <TAB> :tabnext<CR>
nnoremap <S-TAB> <C-W>w 

"" Chargement du fichier de plugins
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif

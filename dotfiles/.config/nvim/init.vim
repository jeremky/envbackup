""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration de NeoVim

" Paramétrage de base
syntax on                       " Active la colorisation syntaxique
set hlsearch                    " Affiche en surbrillance les recherches
set background=dark             " Optimise l'affiche pour un terminal sombre
set laststatus=2                " Affiche en permanence la barre de statut
set noshowmode                  " Désactive les informations d'état
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
set nobackup                    " Désactive les sauvegardes automatiques
set number                      " Affiche les numéros de ligne
set spelllang=en,fr             " Spécifie les langues du dictionnaire

" Permet l'indentation automatique : gg=G
filetype plugin indent on

" Définition des caractères invisibles
let &listchars = "eol:$,space:\u00B7"

" Changement automatique du curseur en fonction du mode
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping

" Nvim-tree
nnoremap <F1> :NvimTreeToggle <CR>
nnoremap <C-o> :NvimTreeToggle <CR>

" Mode IDE
nnoremap <F2> :call ModeIDE() <CR>
function! ModeIDE()
  set number!
  IBLToggle
  echo "Mode IDE"
endfunction

" Correction orthographique (z= pour afficher les propositions)
map <F3> :set spell!<CR>

" Terminal
nnoremap <F4> :ToggleTerm<CR>

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

" Réduction du code
nnoremap <F8> :call ToggleFold()<CR>
function! ToggleFold()
  if &foldmethod == 'indent'
    set foldmethod=syntax
    echo "Mode Fold désactivé"
  else
    set foldmethod=indent
    set foldlevel=1
    set foldclose=all
    echo "Mode Fold activé"
  endif
endfunction

" Changement de document
nnoremap <S-TAB> <C-W>w
nnoremap <TAB> :tabnext<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

" Téléchargement de vim-plug si introuvable
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Lance automatiquement PlugInstall
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

" Liste des plugins
call plug#begin()

" Theme
Plug 'navarasu/onedark.nvim'

" Interface
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/toggleterm.nvim'

" Code
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kylechui/nvim-surround'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

call plug#end()

" Chargement automatique des fichiers de config
lua << EOF
local plugin_path = vim.fn.stdpath("config") .. "/plugins"

for _, file in ipairs(vim.fn.glob(plugin_path .. "/*.lua", true, true)) do
    dofile(file)
end
EOF

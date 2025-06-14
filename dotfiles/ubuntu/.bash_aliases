##################################################################
## Bash

# Affichage
if [[ $USER = root ]]; then
  PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
fi

# Variables
export LANG=fr_FR.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export EDITOR=vim
export VISUAL=$EDITOR

# Tweaks divers
bind 'set colored-stats on'              # Affiche les couleurs lors de la complétion
bind 'set completion-ignore-case on'     # Ignorer la casse lors de la complétion
bind 'set mark-symlinked-directories on' # Meilleure gestion des liens symboliques
bind 'set show-all-if-unmodified on'     # Affiche les correspondances possibles immédiatement

# Sudo : utiliser la commande root pour...passer root :)
if [[ -f /usr/bin/sudo ]] && [[ $USER != root ]]; then
  alias root='sudo -i'
  sudo=sudo
fi

##################################################################
## Commandes

# Prompt
alias ls='ls --color=auto'                       # Ajoute la couleur
alias l='ls -lh'                                 # Liste détaillée
alias la='ls -lhA'                               # Liste avec les fichiers cachés
alias lr='ls -lLhR'                              # Liste en récursif
alias lra='ls -lhRA'                             # Liste en récursif avec les fichiers cachés
alias lrt='ls -lLhrt'                            # Liste par date
alias lrta='ls -lLhrtA'                          # Liste par date avec les fichiers cachés
alias grep='grep -i --color=auto'                # Grep sans la sensibilité à la casse
alias zgrep='zgrep -i --color=auto'              # Grep dans les fichiers compressés
alias psp='ps -eaf | grep -v grep | grep'        # Chercher un process (psp <nom process>)
alias iostat='iostat -m --human'                 # Commande iostat lisible
alias ifconfig='ip -br -c addr | grep -v lo'     # Afficher les adresses IP (ifconfig n'existe plus)
alias ss='ss -tunlH'                             # Afficher les ports d'écoute
alias ssp='ss | grep'                            # Chercher un port (ssp <port>)
alias netstat='ss'                               # Afficher les ports d'écoute (netstat n'existe plus)
alias md5='md5sum <<<'                           # Facilite l'utilisation de la commande md5
alias pubip='curl -s -4 ipecho.net/plain ; echo' # Pour obtenir l'adresse IP publique du serveur
alias df='df -h -x tmpfs -x devtmpfs -x overlay' # Commande df en filtrant les montages inutiles
alias halt='$sudo halt -p'                       # Arrête le système et le serveur
alias reboot='$sudo reboot'                      # Commande reboot avec sudo

# ssh
alias genkey='ssh-keygen -t ed25519 -a 100'
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100'
alias copykey='ssh-copy-id'

##################################################################
## Applications

# apt : gestionnaire de paquets
if [[ -f /usr/bin/apt ]]; then
  alias apt='$sudo apt'
  alias upgrade='$sudo apt update && $sudo apt full-upgrade && $sudo apt -y autoremove'
fi

# colordiff : diff avec couleur
if [[ -f /usr/bin/colordiff ]]; then
  alias diff='colordiff'
fi

# duf : affiche les files systems
if [[ -f /usr/bin/duf ]]; then
  alias df='duf -hide special'
fi

# fd : find amélioré
if [[ -f /usr/bin/fdfind ]]; then
  alias fd='fdfind'
fi

# fzf : recherche avancée
if [[ -f /usr/bin/fzf ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.bash
  # export FZF_DEFAULT_OPTS="--no-color"
  export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=border:#363a4f,label:#cad3f5"
fi

# htop : plus convivial que top
if [[ -f /usr/bin/htop ]]; then
  alias top='htop'
fi

# ncdu : équivalent à TreeSize
if [[ -f /usr/bin/ncdu ]]; then
  alias ncdu='ncdu --color dark'
fi

# podman : remplaçant de docker
if [[ -f /usr/bin/podman ]]; then
  alias docker='podman'
  alias docker-compose='podman-compose'
fi

# rg : plus performant que grep
if [[ -f /usr/bin/rg ]]; then
  alias rg='rg -i'
fi

# tmux : émulateur de terminal
if [[ -f /usr/bin/tmux ]]; then
  alias tmux='tmux attach || tmux new'
fi

# ufw : ajoute sudo
if [[ -f /usr/sbin/ufw ]]; then
  alias ufw='$sudo ufw'
  alias ufws='$sudo ufw status numbered'
fi

# vim : vi amélioré
if [[ -f ~/.local/nvim/bin/nvim ]]; then
  alias vi='nvim -nO'
elif [[ -f /usr/bin/vim ]]; then
  alias vi='vim -nO'
fi

# zoxide : cd amélioré
if [[ -f /usr/bin/zoxide ]]; then
  eval "$(zoxide init bash)"
  alias cd='z'
fi

##################################################################
## Fonctions

# cpsave : copie un fichier ou un dossier avec .old
cpsave() { cp -Rp $1 "$(echo $1 | cut -d '/' -f 1)".old; }

# newuser : créé un compte de service
newuser() {
  $sudo adduser --no-create-home -q --disabled-password --comment "" $1
  echo "Utilisateur $1 créé. ID : $(id -u $1)"
}

# replace : commande sed plus conviviale
replace() { sed -i "s|$1|$2|g" $3; }

# replaceall : commande sed plus conviviale recursive
replaceall() { rg -sl $1 | xargs sed -i "s|$1|$2|g"; }

# tarc : créer une archive pour chaque fichier / dossier spécifié
tarc() { for file in $*; do tar czvf "$(echo $file | cut -d '/' -f 1)".tar.gz $file; done; }

# tarx : décompresse une archive spécifiée
tarx() { for file in $*; do tar xzvf $file; done; }

# zip : commande zip plus conviviale
zip() { /usr/bin/zip -r "$(echo "$1" | cut -d '/' -f 1)".zip $*; }

##################################################################
## Scripts

# Transforme les scripts en alias
scripts=/home/jeremky/Documents/scripts
if [[ -d $scripts ]]; then
  for i in $(ls $scripts); do
    if [[ -f $scripts/$i/$i.sh ]]; then
      alias $i=''$scripts'/'$i'/'$i'.sh'
    fi
  done
fi

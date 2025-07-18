##################################################################
## Bash

# Affichage
if [[ "$USER" = "root" ]]; then
  PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
  PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
fi

# Variables
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1
export EDITOR=vim
export VISUAL=$EDITOR

# Tweaks divers
bind 'set colored-stats on'              # Affiche les couleurs lors de la complétion
bind 'set completion-ignore-case on'     # Ignorer la casse lors de la complétion
bind 'set mark-symlinked-directories on' # Meilleure gestion des liens symboliques
bind 'set show-all-if-unmodified on'     # Affiche les correspondances possibles immédiatement

# Sudo : utiliser la commande root pour...passer root :)
if [[ "$USER" != "root" ]]; then
  alias root='sudo -i'
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
alias upgrade='ujust update'                     # Mise à jour de Bazzite

# ssh
alias genkey='ssh-keygen -t ed25519 -a 100'
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100'
alias copykey='ssh-copy-id'

##################################################################
## Applications

# duf : affiche les files systems
[[ -f /usr/bin/duf ]] && alias df='duf -hide special'

# fzf : recherche avancée
if [[ -f /usr/bin/fzf ]]; then
  source <(fzf --bash)
  export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=border:#363a4f,label:#cad3f5"
fi

# htop : plus convivial que top
[[ -f /var/home/linuxbrew/.linuxbrew/bin/htop ]] && alias top='htop'

# ncdu : équivalent à TreeSize
[[ -f /var/home/linuxbrew/.linuxbrew/bin/ncdu ]] && alias ncdu='ncdu --color dark'

# rg : plus performant que grep
[[ -f /usr/bin/rg ]] && alias rg='rg -i'

# zoxide : cd amélioré
if [[ -f /var/home/linuxbrew/.linuxbrew/bin/zoxide ]]; then
  eval "$(zoxide init bash)"
  alias cd='z'
fi

# vim : Vi amélioré
[[ -f /usr/bin/vim ]] && alias vi='vim -nO'

##################################################################
## Fonctions

# cpsave : copie un fichier ou un dossier avec .old
cpsave() { cp -Rp $1 "$(echo $1 | cut -d '/' -f 1)".old; }

# tarc : créer une archive pour chaque fichier / dossier spécifié
tarc() { for file in $*; do tar czvf "$(echo $file | cut -d '/' -f 1)".tar.gz $file; done; }

# tarx : décompresse une archive spécifiée
tarx() { for file in $*; do tar xzvf $file; done; }

# testdisk
testdisk() { dd if=/dev/zero of=testfile bs=64M count=16 oflag=direct ; rm testfile ;}

# zip : commande zip plus conviviale
zip() { /usr/bin/zip -r "$(echo "$1" | cut -d '/' -f 1)".zip $*; }

##################################################################
## Scripts

# Transforme les scripts en alias
scripts=/var/home/jeremky/Documents/scripts
if [[ -d $scripts ]]; then
  for i in $(ls $scripts); do
    if [[ -f $scripts/$i/$i.sh ]]; then
      alias $i=''$scripts'/'$i'/'$i'.sh'
    fi
  done
fi

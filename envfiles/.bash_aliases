##################################################################
## Prompt

## Affichage
if [ $USER = root ] ; then
  PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
fi

## Variables
export LANG=fr_FR.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export EDITOR=vi
export VISUAL=$EDITOR
export TMOUT=1800

## Tweaks divers
bind 'set colored-stats on'                           # Affiche les couleurs lors de la complétion
bind 'set completion-ignore-case on'                  # Ignorer la casse lors de la complétion
bind 'set mark-symlinked-directories on'              # Meilleure gestion des liens symboliques
bind 'set show-all-if-unmodified on'                  # Affiche les correspondances possibles immédiatement

## Sudo : utiliser la commande root pour...passer root :)
if [ -f /usr/bin/sudo ] && [ $USER != root ] ; then
  alias root='sudo -i'
  alias su='sudo -s'
  sudo=sudo
fi


##################################################################
## Commandes

alias ls='ls --color=auto'                            # Ajoute la couleur
alias l='ls -lh'                                      # Liste détaillée
alias la='ls -lhA'                                    # Liste avec les fichiers cachés
alias lr='ls -lLhR'                                   # Liste en récursif
alias lra='ls -lhRA'                                  # Liste en récursif avec les fichiers cachés
alias lrt='ls -lLhrt'                                 # Liste par date
alias lrta='ls -lLhrtA'                               # Liste par date avec les fichiers cachés
alias grep='grep -i --color=auto'                     # Grep sans la sensibilité à la casse
alias zgrep='zgrep -i --color=auto'                   # Grep dans les fichiers compressés
alias psp='ps -eaf | grep -v grep | grep'             # Chercher un process (psp <nom process>)
alias iostat='iostat -m --human'                      # Commande iostat lisible
alias ifconfig='ip -br -c addr | grep -v lo'          # Afficher les adresses IP (ifconfig n'existe plus)
alias ss='ss -tunlH'                                  # Afficher les ports d'écoute
alias ssp='ss | grep'                                 # Chercher un port (ssp <port>)
alias netstat='ss'                                    # Afficher les ports d'écoute (netstat n'existe plus)
alias md5='md5sum <<<'                                # Facilite l'utilisation de la commande md5
alias pubip='curl -s -4 ipecho.net/plain ; echo'      # Pour obtenir l'adresse IP publique du serveur
alias df='df -h -x tmpfs -x devtmpfs -x overlay'      # Commande df en filtrant les montages inutiles
alias halt='$sudo halt -p'                            # Arrête le système et le serveur
alias reboot='$sudo reboot'                           # Commande reboot avec sudo

## Ssh
alias genkey='ssh-keygen -t ed25519 -a 100'
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100'
alias copykey='ssh-copy-id'


##################################################################
## Applications

# apt : gestionnaire de paquets
if [ -f /usr/bin/apt ] ; then
  alias apt='$sudo apt'
  alias upgrade='$sudo apt update && $sudo apt full-upgrade && $sudo apt -y autoremove'
fi

# colordiff : diff avec couleur
if [ -f /usr/bin/colordiff ] ; then
  alias diff='colordiff'
fi

# duf : affiche les files systems
if [ -f /usr/bin/duf ] ; then
  alias df='duf -hide special'
fi

# htop : plus convivial que top
if [ -f /usr/bin/htop ] ; then
  alias top='htop'
fi

# ncdu : équivalent à TreeSize
if [ -f /usr/bin/ncdu ] ; then
  alias ncdu='ncdu --color dark'
fi

# rg : plus performant que grep
if [ -f /usr/bin/rg ] ; then
  alias rg='rg -i'
fi

# tmux : émulateur de terminal
if [ -f /usr/bin/tmux ] ; then
  alias tmux='tmux attach || tmux new'
fi

# ufw : ajoute sudo
if [ -f /usr/sbin/ufw ] ; then
  alias ufw='$sudo ufw'
  alias ufws='$sudo ufw status numbered'
fi

# vim : Vi amélioré
if [ -f /usr/bin/nvim ] ; then
  alias vi='nvim -nO'
  alias vim='vim.tiny -nO -u ~/.vim/vimtiny'
elif [ -f /usr/bin/vim ] ; then
  alias vi='vim -nO'
fi


##################################################################
## Fonctions

# cpsave : copie un fichier ou un dossier avec .old
cpsave() { cp -Rp $1 "$(echo $1 | cut -d '/' -f 1)".old ;}

# jsed : commande sed plus conviviale
jsed() { sed -i "s|$1|$2|g" $3 ;}

# newuser : créé un compte de service
newuser() { $sudo adduser --no-create-home -q --disabled-password --comment "" $1 ; echo "Utilisateur $1 créé. ID : $(id -u $1)" ;}

# tarc : créer une archive pour chaque fichier / dossier spécifié
tarc() { for file in $* ; do tar czvf "$(echo $file | cut -d '/' -f 1)".tar.gz $file ; done ;}

# tarx : décompresse une archive spécifiée
tarx() { for file in $* ; do tar xzvf $file ; done ;}

# zip : commande zip plus conviviale
zip() { /usr/bin/zip -r "$(echo "$1" | cut -d '/' -f 1)".zip $* ;}


##################################################################
## Docker

# podman : remplaçant de docker
if [ -f /usr/bin/podman ] ; then
  alias docker='$sudo podman'
  alias docker-compose='$sudo podman-compose'
  alias podman='$sudo podman'
  alias podman-compose='$sudo podman-compose'
fi

# lazydocker : outil de monitoring
if [ -f /usr/bin/lazydocker ] ; then
  lzd() { if [ ! -h /var/run/docker.sock ] ; then $sudo ln -s /var/run/podman/podman.sock /var/run/docker.sock ; fi ; $sudo lazydocker ;}
fi


##################################################################
## Scripts

# Transforme en alias les scripts
scripts=/home/jeremky/scripts
if [ -d $scripts ] ; then
  for i in $(ls $scripts) ; do
    if [ -f $scripts/$i/$i.sh ] ; then
      alias $i=''$scripts'/'$i'/'$i'.sh'
    fi
  done
fi

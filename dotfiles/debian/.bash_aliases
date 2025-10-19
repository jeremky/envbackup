###############################################################
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
export EDITOR=$VISUAL
export TMOUT=1800

# Tweaks divers
if [[ $- == *i* ]]; then
  bind 'set colored-stats on'              # Affiche les couleurs lors de la complétion
  bind 'set completion-ignore-case on'     # Ignorer la casse lors de la complétion
  bind 'set show-all-if-unmodified on'     # Affiche les correspondances possibles immédiatement
  bind 'set show-all-if-ambiguous on'      # Saisie automatique à partir des correspondances
fi

###############################################################
## Commandes

# Prompt
alias ls='ls --color=auto'                         # Ajoute la couleur
alias l='ls -lh'                                   # Liste détaillée
alias la='ls -lhA'                                 # Liste avec les fichiers cachés
alias lr='ls -lLhR'                                # Liste en récursif
alias lra='ls -lhRA'                               # Liste en récursif avec les fichiers cachés
alias lrt='ls -lLhrt'                              # Liste par date
alias lrta='ls -lLhrtA'                            # Liste par date avec les fichiers cachés
alias grep='grep -i --color=auto'                  # Grep sans la sensibilité à la casse
alias zgrep='zgrep -i --color=auto'                # Grep dans les fichiers compressés
alias psp='ps -eaf | grep -v grep | grep'          # Chercher un process (psp <nom process>)
alias iostat='iostat -m --human'                   # Commande iostat lisible
alias ifconfig='ip -br -c addr | grep -v lo'       # Afficher les adresses IP (ifconfig n'existe plus)
alias ss='ss -tunlH'                               # Afficher les ports d'écoute
alias ssp='ss | grep'                              # Chercher un port (ssp <port>)
alias netstat='ss'                                 # Afficher les ports d'écoute (netstat n'existe plus)
alias md5='md5sum <<<'                             # Facilite l'utilisation de la commande md5
alias pubip='curl -s -4 ipecho.net/plain ; echo'   # Pour obtenir l'adresse IP publique du serveur
alias df='df -h -x tmpfs -x devtmpfs -x overlay'   # Commande df en filtrant les montages inutiles
alias halt='sudo halt -p'                          # Arrête le système et le serveur
alias reboot='sudo reboot'                         # Commande reboot avec sudo

# sudo : utiliser la commande root pour...passer root :)
[[ $USER != root ]] && alias root='sudo -i'

# ssh
alias genkey='ssh-keygen -t ed25519 -a 100'        # Générer une clé ed25519
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100' # Générer une clé RSA
alias copykey='ssh-copy-id'                        # Copier la clé ssh vers un serveur

# apt : gestionnaire de paquets debian
alias apt='sudo apt'
alias upgrade='sudo apt update && sudo apt full-upgrade && sudo apt -y autoremove'

###############################################################
## Applications facultatives

# colordiff : diff avec couleur
[[ -f /usr/bin/colordiff ]] && alias diff='colordiff'

# duf : df amélioré
[[ -f /usr/bin/duf ]] && alias df='duf -hide special'

# fd : find amélioré
[[ -f /usr/bin/fdfind ]] && alias fd='fdfind -HI'

# fzf : recherche avancée
if [[ -f /usr/bin/fzf ]]; then
  eval "$(fzf --bash)"
  #export FZF_DEFAULT_OPTS="--color=bw"
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
    --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
    --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
    --color=selected-bg:#494D64 \
    --color=border:#6E738D,label:#CAD3F5"
fi

# htop : plus convivial que top
[[ -f /usr/bin/htop ]] && alias top='htop'

# ncdu : équivalent à TreeSize
[[ -f /usr/bin/ncdu ]] && alias ncdu='ncdu --color dark'

# rg : plus performant que grep
[[ -f /usr/bin/rg ]] && alias rg='rg -i --no-ignore'

# ufw : firewall simplifié
if [[ -f /usr/sbin/ufw ]]; then
  alias ufw='sudo ufw'
  alias ufws='sudo ufw status numbered'
fi

# vim : vi amélioré
[[ -f /usr/bin/vim ]] && alias vi='vim -nO'

# zoxide : cd amélioré (utiliser la commande z)
[[ -f /usr/bin/zoxide ]] && eval "$(zoxide init bash)"

###############################################################
## Fonctions

# cleanlog : ménage des logs de systemd
cleanlog() { sudo journalctl --vacuum-time=$1d ;}

# cpsave : copie un fichier ou un dossier avec .old
cpsave() { cp -Rp $1 "$(echo $1 | cut -d '/' -f 1)".old ;}

# gencert : générer un certificat avec certbot
gencert () { sudo certbot certonly --standalone -d $1 ;}

# newuser : créé un compte de service
newuser() {
  sudo adduser --no-create-home -q --disabled-password --comment "" $1
  echo "Utilisateur $1 créé. ID : $(id -u $1)"
}

# tarc : créer une archive pour chaque fichier / dossier spécifié
tarc() { for file in $*; do tar czvf "$(echo $file | cut -d '/' -f 1)".tar.gz $file; done ;}

# tarx : décompresse une archive spécifiée
tarx() { for file in $*; do tar xzvf $file; done ;}

# testdisk
testdisk() { dd if=/dev/zero of=testfile bs=64M count=16 oflag=direct ; rm testfile ;}

# zip : commande zip plus conviviale
zip() { /usr/bin/zip -r "$(echo "$1" | cut -d '/' -f 1)".zip $* ;}

###############################################################
## Scripts

# Transforme les scripts en alias
scripts=/home/jeremky/scripts
if [[ -d $scripts ]]; then
  for i in $(ls $scripts); do
    if [[ -f $scripts/$i/$i.sh ]]; then
      alias $i=''$scripts'/'$i'/'$i'.sh'
    fi
  done
fi

###############################################################
## Podman

# alias docker
[[ -f /usr/bin/podman ]] && alias docker='podman'
[[ -f /usr/bin/podman-compose ]] && alias docker-compose='podman-compose'

# lazydocker
if [[ -f ~/.local/bin/lazydocker ]]; then
  export DOCKER_HOST=unix:///var/run/user/$(id -g)/podman/podman.sock
  alias lzd='lazydocker'
fi

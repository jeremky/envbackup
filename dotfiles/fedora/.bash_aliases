###############################################################
## Bash

# Affichage
if [[ "$EUID" -eq 0 ]]; then
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
export HISTTIMEFORMAT="%F %T "

# Tweaks divers
if [[ $- == *i* ]]; then
  bind 'set colored-stats on'          # Affiche les couleurs lors de la complétion
  bind 'set completion-ignore-case on' # Ignorer la casse lors de la complétion
  bind 'set show-all-if-unmodified on' # Affiche les correspondances possibles immédiatement
fi

###############################################################
## Commandes

# Prompt
alias ls='ls --color=auto'                       # Ajoute la couleur
alias l='ls -lh'                                 # Liste détaillée
alias la='ls -lhA'                               # Liste avec les fichiers cachés
alias lr='ls -lLhR'                              # Liste en récursif
alias lra='ls -lhRA'                             # Liste en récursif avec les fichiers cachés
alias lrt='ls -lLhrt'                            # Liste par date
alias lrta='ls -lLhrtA'                          # Liste par date avec les fichiers cachés
alias dus='du -sh * | sort -hr'                  # Tri de fichiers et dossiers par taille
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

# sudo : utiliser la commande root pour...passer root :)
[[ "$EUID" -ne 0 ]] && alias root='sudo -s'

# ssh
alias genkey='ssh-keygen -t ed25519 -a 100'        # Générer une clé ed25519
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100' # Générer une clé RSA

# dnf : gestionnaire de paquets fedora
alias dnf='sudo dnf'
alias upgrade='sudo dnf -y upgrade && sudo dnf -y autoremove'

###############################################################
## Applications facultatives

# colordiff : diff avec couleur
[[ -f /usr/bin/colordiff ]] && alias diff='colordiff'

# duf : df amélioré
[[ -f /usr/bin/duf ]] && alias df='duf -hide special'

# fd : find amélioré
[[ -f /usr/bin/fd ]] && alias fd='fd -HI'

# fzf : recherche avancée
if [[ -f /usr/bin/fzf ]]; then
  eval "$(fzf --bash)"
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4"
fi

# htop : plus convivial que top
[[ -f /usr/bin/htop ]] && alias top='htop'

# ncdu : équivalent à TreeSize
[[ -f /usr/bin/ncdu ]] && alias ncdu='ncdu --color dark'

# rg : plus performant que grep
[[ -f /usr/bin/rg ]] && alias rg='rg -i --no-ignore'

# vim : vi amélioré
[[ -f /usr/bin/vim ]] && alias vi='vim -nO'

# zoxide : cd amélioré (utiliser la commande z)
[[ -f /usr/bin/zoxide ]] && eval "$(zoxide init bash)"

###############################################################
## Fonctions

# cleanlog : nettoyer les logs de systemd
cleanlog() { [[ -n "$1" ]] && sudo journalctl --vacuum-time=${1}d; }

# cpsave : copier un fichier ou un dossier avec .old
cpsave() { cp -Rp "$1" "${1%/}.$(date +%Y%m%d).old"; }

# tarc : créer une archive tar.gz pour chaque fichier / dossier spécifié
tarc() { for file in "$@"; do tar czvf "${file%/}.tar.gz" "$file"; done; }

# tarx : décompresse une archive tar spécifiée
tarx() { for file in "$@"; do tar xvf "$file"; done; }

# testdisk : tester la vitesse d'écriture du disque
testdisk() {
  dd if=/dev/zero of=testfile bs=64M count=16 oflag=direct status=progress
  rm testfile
}

# ─── .bash_aliases ───────────────────────────────────────────────────────

# ls colors
hidden=".gitignore .history .old"
for file in $hidden; do
  export LS_COLORS="$LS_COLORS:*$file=00;90"
done

# options
if [[ $- == *i* ]]; then
  bind 'set colored-stats on'          # Couleurs lors de la complétion
  bind 'set completion-ignore-case on' # Ignorer la casse lors de la complétion
  bind 'set show-all-if-unmodified on' # Affiche les correspondances immédiatement
fi

# prompt
if [[ "$EUID" -eq 0 ]]; then
  PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
fi

# variables
export LANG=fr_FR.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export EDITOR=vim
export VISUAL=$EDITOR

# ─── aliases ─────────────────────────────────────────────────────────────

alias ls='ls --color=auto'                               # Ajoute la couleur
alias l='ls -lh'                                         # Liste détaillée
alias la='ls -lhA'                                       # Liste avec les fichiers cachés
alias lr='ls -lLhR'                                      # Liste en récursif
alias lra='ls -lhRA'                                     # Liste en récursif avec les fichiers cachés
alias lrt='ls -lLhrt'                                    # Liste par date
alias lrta='ls -lLhrtA'                                  # Liste par date avec les fichiers cachés
alias dus='du -sh * | sort -hr'                          # Tri par taille
alias grep='grep -i --color=auto'                        # Grep sans sensibilité à la casse
alias zgrep='zgrep -i --color=auto'                      # Grep dans les fichiers compressés
alias psp='ps -eaf | grep -v grep | grep'                # Chercher un process (psp <nom>)
alias iostat='iostat -m --human'                         # iostat lisible
alias ifc='ip -br -c addr | grep -vw lo'                 # Adresses IP (ifconfig obsolète)
alias ssp='ss -tunlH | grep'                             # Chercher un port (ssp <port>)
alias pubip='curl -s -4 https://ipecho.net/plain ; echo' # IP publique
alias df='df -h -x tmpfs -x devtmpfs -x overlay'         # df sans montages inutiles
alias halt='sudo halt -p'                                # Arrêt système
alias reboot='sudo reboot'                               # Redémarrage

# sudo
[[ "$EUID" -ne 0 ]] && alias root='sudo -s'

# ssh
alias genkey='ssh-keygen -t ed25519 -a 100'        # Clé ed25519
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100' # Clé RSA

# ─── applications facultatives ───────────────────────────────────────────

# apt : gestionnaire de paquets deb
if command -v apt &>/dev/null; then
  alias apt='sudo apt'
  alias upgrade='sudo apt update && sudo apt full-upgrade && sudo apt -y autoremove'
fi

# btop / htop : top amélioré
if command -v btop &>/dev/null; then
  alias top='btop'
elif command -v htop &>/dev/null; then
  alias top='htop'
fi

# dnf : gestionnaire de paquets rpm
if command -v dnf &>/dev/null; then
  alias dnf='sudo dnf'
  alias upgrade='sudo dnf -y upgrade && sudo dnf -y autoremove'
fi

# duf : df amélioré
if command -v duf &>/dev/null; then
  alias df='duf -hide special --hide-mp /boot'
fi

# dust : du amélioré
if command -v dust &>/dev/null; then
  alias dus='dust -rb'
fi

# eopkg : gestionnaire de paquets solus
if command -v eopkg &>/dev/null; then
  alias eo='sudo eopkg'
  alias upgrade='sudo eopkg up && sudo eopkg rmo'
fi

# fd : find amélioré
if command -v fdfind &>/dev/null; then
  alias fd='fdfind -HI'
  export FZF_DEFAULT_COMMAND='fdfind -HI'
elif command -v fd &>/dev/null; then
  alias fd='fd -HI'
  export FZF_DEFAULT_COMMAND='fd -HI'
fi

# fzf : recherche avancée avec thème Catppuccin Mocha
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4"
fi

# herdr : émulateur de terminal
if command -v herdr &>/dev/null; then
  alias hr='herdr'
  alias hrstop='herdr session stop default'
fi

# icdiff : diff amélioré
if command -v icdiff &>/dev/null; then
  alias diff='icdiff -N'
elif command -v colordiff &>/dev/null; then
  alias diff='colordiff'
fi

# ncdu : équivalent à TreeSize
if command -v ncdu &>/dev/null; then
  alias ncdu='ncdu --color dark'
fi

# procs : ps amélioré
if command -v procs &>/dev/null; then
  alias psp='procs'
fi

# rg : plus performant que grep
if command -v rg &>/dev/null; then
  alias rg='rg -i --no-ignore'
fi

# tty-clock : horloge en CLI
if command -v tty-clock &>/dev/null; then
  alias clock='tty-clock -c -f %d/%m/%Y'
fi

# ufw : firewall simplifié
if command -v ufw &>/dev/null; then
  alias ufw='sudo ufw'
  alias ufws='sudo ufw status numbered'
fi

# vim : vi amélioré
if command -v vim &>/dev/null; then
  alias vi='vim -O'
fi

# zed : éditeur de code
if command -v zed &>/dev/null; then
  alias e='zed'
elif command -v zedit &>/dev/null; then
  alias e='zedit'
fi

# zoxide : cd amélioré
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# ─── fonctions ───────────────────────────────────────────────────────────

# cleanlog : nettoyer les logs systemd
cleanlog() { [[ -n "$1" ]] && sudo journalctl --vacuum-time="${1}"d; }

# cpsave : copier un fichier ou dossier avec suffixe .old
cpsave() { cp -Rp "$1" "${1%/}.old"; }

# md5 : MD5 d'une chaîne
md5() { printf '%s' "$1" | md5sum | cut -d' ' -f1; }

# tarc : créer une archive tar.gz
tarc() { for file in "$@"; do tar czvf "${file%/}.tar.gz" "$file"; done; }

# tarx : décompresser une archive tar
tarx() { for file in "$@"; do tar xvf "$file"; done; }

# diskbench : tester la vitesse d'écriture disque
diskbench() {
  dd if=/dev/zero of=testfile bs=64M count=16 oflag=direct status=progress
  rm testfile
}

# webi : gestionnaire de paquets
webinstall() {
  curl -sS https://webi.sh/webi | sh
  source "$HOME/.config/envman/PATH.env"
}

# zipd : créer une archive zip par dossier/fichier donné
zipd() { for file in "$@"; do /usr/bin/zip -r "${file%/}.zip" "$file"; done; }

# ─── scripts ─────────────────────────────────────────────────────────────

# Transforme les scripts en alias
scripts=~/Documents/scripts
if [[ -d $scripts ]]; then
  for i in "$scripts"/*; do
    scr=${i##*/}
    # shellcheck disable=SC2139,SC2086
    [[ -f "$scripts/$scr/$scr.sh" ]] && alias $scr="$scripts/$scr/$scr.sh"
  done
fi

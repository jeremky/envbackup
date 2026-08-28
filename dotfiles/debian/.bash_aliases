# ─── .bash_aliases ───────────────────────────────────────────────────────────

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
export HISTTIMEFORMAT="%F %T "
export LESSHISTFILE=/dev/null
export TMOUT=3600

# options
if [[ $- == *i* ]]; then
  bind 'set colored-stats on'          # Couleurs lors de la complétion
  bind 'set completion-ignore-case on' # Ignorer la casse lors de la complétion
  bind 'set show-all-if-unmodified on' # Affiche les correspondances immédiatement
fi

# ─── aliases ─────────────────────────────────────────────────────────────────

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
alias ifconfig='ip -br -c addr | grep -vw lo'            # Adresses IP (ifconfig obsolète)
alias ss='ss -tunlH'                                     # Ports d'écoute
alias ssp='ss | grep'                                    # Chercher un port (ssp <port>)
alias netstat='ss'                                       # Alias netstat obsolète → ss
alias pubip='curl -s -4 https://ipecho.net/plain ; echo' # IP publique
alias df='df -h -x tmpfs -x devtmpfs -x overlay'         # df sans montages inutiles
alias halt='sudo halt -p'                                # Arrêt système
alias reboot='sudo reboot'                               # Redémarrage

# sudo
[[ "$EUID" -ne 0 ]] && alias root='sudo -s'

# ssh
alias genkey='ssh-keygen -t ed25519 -a 100'        # Clé ed25519
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100' # Clé RSA

# apt
alias apt='sudo apt'
alias upgrade='sudo apt update && sudo apt full-upgrade && sudo apt -y autoremove'

# ─── applications facultatives ───────────────────────────────────────────────

# colordiff : diff avec couleur
command -v colordiff &>/dev/null && alias diff='colordiff'

# duf : df amélioré
command -v duf &>/dev/null && alias df='duf -hide special'

# dust : du amélioré
command -v dust &>/dev/null && alias d='dust -rb'

# fd : find amélioré
command -v fdfind &>/dev/null && alias fd='fdfind -HI'

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

# htop : plus convivial que top
command -v htop &>/dev/null && alias top='htop'

# ncdu : équivalent à TreeSize
command -v ncdu &>/dev/null && alias ncdu='ncdu --color dark'

# procs : ps amélioré
command -v procs &>/dev/null && alias psp='procs'

# rg : plus performant que grep
command -v rg &>/dev/null && alias rg='rg -i --no-ignore'

# tty-clock : horloge en CLI
command -v tty-clock &>/dev/null && alias clock='tty-clock -c -f %d/%m/%Y'

# ufw : firewall simplifié
if command -v ufw &>/dev/null; then
  alias ufw='sudo ufw'
  alias ufws='sudo ufw status numbered'
fi

# vim : vi amélioré
command -v vim &>/dev/null && alias vi='vim -nO'

# zoxide : cd amélioré
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"

# ─── fonctions ───────────────────────────────────────────────────────────────

# cleanlog : nettoyer les logs systemd
cleanlog() { [[ -n "$1" ]] && sudo journalctl --vacuum-time=${1}d; }

# cpsave : copier un fichier ou dossier avec suffixe .old
cpsave() { cp -Rp "$1" "${1%/}.$(date +%Y%m%d).old"; }

# gencert : générer un certificat avec certbot
gencert() { sudo certbot certonly --standalone -d "$1"; }

# md5 : MD5 d'une chaîne
md5() { printf '%s' "$1" | md5sum | cut -d' ' -f1; }

# newuser : créer un compte de service
newuser() {
  sudo adduser --no-create-home -q --disabled-password --comment "" "$1"
  echo "Utilisateur $1 créé. ID : $(id -u "$1")"
}

# tarc : créer une archive tar.gz
tarc() { for file in "$@"; do tar czvf "${file%/}.tar.gz" "$file"; done; }

# tarx : décompresser une archive tar
tarx() { for file in "$@"; do tar xvf "$file"; done; }

# diskbench : tester la vitesse d'écriture disque
diskbench() {
  dd if=/dev/zero of=testfile bs=64M count=16 oflag=direct status=progress
  rm testfile
}

# zipd : créer une archive zip par dossier/fichier donné
zipd() { for file in "$@"; do /usr/bin/zip -r "${file%/}.zip" "$file"; done; }

# ─── scripts ─────────────────────────────────────────────────────────────────

# Transforme les scripts en alias
scripts=~/scripts
if [[ -d $scripts ]]; then
  for i in "$scripts"/*; do
    scr=$(basename "$i")
    # shellcheck disable=SC2139
    [[ -f "$scripts/$scr/$scr.sh" ]] && alias $scr="$scripts/$scr/$scr.sh"
  done
fi

# ─── .bash_aliases ────────────────────────────────────────────

# prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '

# variables
export LANG=fr_FR.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export EDITOR=vim
export VISUAL=$EDITOR
export HISTTIMEFORMAT="%F %T "

# options
if [[ $- == *i* ]]; then
  bind 'set colored-stats on'          # Couleurs lors de la complétion
  bind 'set completion-ignore-case on' # Ignorer la casse lors de la complétion
  bind 'set show-all-if-unmodified on' # Affiche les correspondances immédiatement
fi

# ─── aliases ──────────────────────────────────────────────────

alias ls='ls --color=auto'                        # Ajoute la couleur
alias l='ls -lh'                                  # Liste détaillée
alias la='ls -lhA'                                # Liste avec les fichiers cachés
alias lr='ls -lLhR'                               # Liste en récursif
alias lra='ls -lhRA'                              # Liste en récursif avec les fichiers cachés
alias lrt='ls -lLhrt'                             # Liste par date
alias lrta='ls -lLhrtA'                           # Liste par date avec les fichiers cachés
alias dus='du -sh * | sort -hr'                   # Tri par taille
alias grep='grep -i --color=auto'                 # Grep sans sensibilité à la casse
alias zgrep='zgrep -i --color=auto'               # Grep dans les fichiers compressés
alias psp='ps -eaf | grep -v grep | grep'         # Chercher un process (psp <nom>)
alias iostat='iostat -m --human'                  # iostat lisible
alias ifconfig='ip -br -c addr | grep -v lo'      # Adresses IP (ifconfig obsolète)
alias ss='ss -tunlH'                              # Ports d'écoute
alias ssp='ss | grep'                             # Chercher un port (ssp <port>)
alias netstat='ss'                                # Alias netstat obsolète → ss
alias pubip='curl -s -4 ipecho.net/plain ; echo'  # IP publique
alias df='df -h -x tmpfs -x devtmpfs -x overlay'  # df sans montages inutiles
alias halt='sudo halt -p'                         # Arrêt système
alias reboot='sudo reboot'                        # Redémarrage

# ─── applications facultatives ────────────────────────────────

# fzf : recherche avancée
if [[ -f /usr/bin/fzf ]]; then
  eval "$(fzf --bash)"
  export FZF_DEFAULT_OPTS="--no-color"
fi

# htop : plus convivial que top
[[ -f /usr/bin/htop ]] && alias top='htop'

# vim : vi amélioré
[[ -f /usr/bin/vim ]] && alias vi='vim -nO'

# ─── fonctions ────────────────────────────────────────────────

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

# zip : créer une archive zip pour chaque fichier / dossier spécifié
zip() { for file in "$@"; do /usr/bin/zip -r "${file%/}.zip" "$file"; done; }

# ─── .bash_aliases ───────────────────────────────────────────────────────

# ls colors
hidden=".gitignore .history .old"
for file in $hidden; do
  export LS_COLORS="$LS_COLORS:*$file=00;90"
done

# options
if [[ $- == *i* ]]; then
  bind 'set colored-stats on'          # Colors during completion
  bind 'set completion-ignore-case on' # Ignore case during completion
  bind 'set show-all-if-unmodified on' # Show matches immediately
fi

# prompt
if [[ "$EUID" -eq 0 ]]; then
  PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
fi

# variables
export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export EDITOR=vim
export VISUAL=$EDITOR

# ─── aliases ─────────────────────────────────────────────────────────────

alias ls='ls --color=auto'                               # Add color
alias l='ls -lh'                                         # Detailed list
alias la='ls -lhA'                                       # List including hidden files
alias lr='ls -lLhR'                                      # Recursive list
alias lra='ls -lhRA'                                     # Recursive list including hidden files
alias lrt='ls -lLhrt'                                    # List by date
alias lrta='ls -lLhrtA'                                  # List by date including hidden files
alias dus='du -sh * | sort -hr'                          # Sort by size
alias grep='grep -i --color=auto'                        # Case-insensitive grep
alias zgrep='zgrep -i --color=auto'                      # Grep in compressed files
alias psp='ps -eaf | grep -v grep | grep'                # Search for a process (psp <name>)
alias iostat='iostat -m --human'                         # Human-readable iostat
alias ifc='ip -br -c addr | grep -vw lo'                 # IP addresses (ifconfig is deprecated)
alias ssp='ss -tunlH | grep'                             # Search for a port (ssp <port>)
alias pubip='curl -s -4 https://ipecho.net/plain ; echo' # Public IP
alias df='df -h -x tmpfs -x devtmpfs -x overlay'         # df without irrelevant mounts
alias halt='sudo halt -p'                                # System shutdown
alias reboot='sudo reboot'                               # Reboot

# sudo
[[ "$EUID" -ne 0 ]] && alias root='sudo -s'

# ssh keygen
alias genkey='ssh-keygen -t ed25519 -a 100'
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100'

# ─── optional applications ───────────────────────────────────────────────

# apt: deb package manager
if command -v apt &>/dev/null; then
  alias apt='sudo apt'
  alias upgrade='sudo apt update && sudo apt full-upgrade && sudo apt -y autoremove'
fi

# dnf: rpm package manager
if command -v dnf &>/dev/null; then
  alias dnf='sudo dnf'
  alias upgrade='sudo dnf -y upgrade && sudo dnf -y autoremove'
fi

# duf: enhanced df
if command -v duf &>/dev/null; then
  alias df='duf -hide special --hide-mp /boot'
fi

# dust: enhanced du
if command -v dust &>/dev/null; then
  alias dus='dust -rb'
fi

# eopkg: Solus package manager
if command -v eopkg &>/dev/null; then
  alias eo='sudo eopkg'
  alias upgrade='sudo eopkg up && sudo eopkg rmo'
fi

# fd: enhanced find
if command -v fdfind &>/dev/null; then
  alias fd='fdfind -HI'
  export FZF_DEFAULT_COMMAND='fdfind -HI'
elif command -v fd &>/dev/null; then
  alias fd='fd -HI'
  export FZF_DEFAULT_COMMAND='fd -HI'
fi

# fzf: fuzzy finder with Catppuccin Mocha theme
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4"
fi

# htop: better top
if command -v htop &>/dev/null; then
  alias top='htop'
fi

# icdiff: enhanced diff
if command -v icdiff &>/dev/null; then
  alias diff='icdiff -N'
elif command -v colordiff &>/dev/null; then
  alias diff='colordiff'
fi

# ncdu: TreeSize equivalent
if command -v ncdu &>/dev/null; then
  alias ncdu='ncdu --color dark'
fi

# procs: enhanced ps
if command -v procs &>/dev/null; then
  alias psp='procs'
fi

# rg: faster than grep
if command -v rg &>/dev/null; then
  alias rg='rg -i --no-ignore'
fi

# tty-clock: CLI clock
if command -v tty-clock &>/dev/null; then
  alias clock='tty-clock -c -f %d/%m/%Y'
fi

# ufw: uncomplicated firewall
if command -v ufw &>/dev/null; then
  alias ufw='sudo ufw'
  alias ufws='sudo ufw status numbered'
fi

# vim: vi improved
if command -v vim &>/dev/null; then
  alias vi='vim -O'
fi

# vim.tiny
if command -v vim.tiny &>/dev/null; then
  alias v='vim.tiny -O'
fi

# zed: code editor
if command -v zed &>/dev/null; then
  alias e='zed'
elif command -v zedit &>/dev/null; then
  alias e='zedit'
fi

# zoxide: enhanced cd
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# ─── functions ───────────────────────────────────────────────────────────

# cleanlog: clean up systemd logs (cleanlog <days>)
cleanlog() { [[ -n "$1" ]] && sudo journalctl --vacuum-time="${1}"d; }

# cpsave: copy a file or directory with a .old suffix
cpsave() { cp -Rp "$1" "${1%/}.old"; }

# md5: MD5 hash of a string
md5() { printf '%s' "$1" | md5sum | cut -d' ' -f1; }

# tarc: create a tar.gz archive
tarc() { for file in "$@"; do tar czvf "${file%/}.tar.gz" "$file"; done; }

# tarx: extract a tar archive
tarx() { for file in "$@"; do tar xvf "$file"; done; }

# diskbench: test disk write speed
diskbench() {
  dd if=/dev/zero of=testfile bs=64M count=16 oflag=direct status=progress
  rm testfile
}

# webi: package manager
webinstall() {
  curl -sS https://webi.sh/webi | sh
  source "$HOME/.config/envman/PATH.env"
}

# zipd: create one zip archive per given file/directory
zipd() { for file in "$@"; do /usr/bin/zip -r "${file%/}.zip" "$file"; done; }

# ─── scripts ─────────────────────────────────────────────────────────────

# Turn scripts into aliases
scripts=~/Documents/scripts
if [[ -d $scripts ]]; then
  for i in "$scripts"/*; do
    scr=${i##*/}
    # shellcheck disable=SC2139,SC2086
    [[ -f "$scripts/$scr/$scr.sh" ]] && alias $scr="$scripts/$scr/$scr.sh"
  done
fi

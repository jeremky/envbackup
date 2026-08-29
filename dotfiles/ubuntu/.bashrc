# ─── .bashrc ─────────────────────────────────────────────

# if not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# history
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s histappend

# options
shopt -s autocd
shopt -s checkwinsize
shopt -s globstar

# aliases
[[ -f ~/.bash_aliases ]] && . "$HOME/.bash_aliases"

# prompt
case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
  *) ;;
esac

# completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

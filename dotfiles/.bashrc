# ─── .bashrc ─────────────────────────────────────────────────────────────

# if not interactive
case $- in
  *i*) ;;
  *) return ;;
esac

# global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# history
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s histappend

# options
shopt -s autocd
shopt -s checkwinsize
shopt -s globstar

# colors
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# aliases
[[ -f ~/.bash_aliases ]] && . "$HOME/.bash_aliases"

# solus
[[ -f /usr/share/defaults/etc/profile ]] && source /usr/share/defaults/etc/profile

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

# envman
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

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
case "$TERM" in
  *-256color)
    export COLORTERM=truecolor
    ;;
esac

# ls colors
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# envman
[[ -s "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"

# aliases
[[ -f ~/.bash_aliases ]] && . "$HOME/.bash_aliases"

case "$(cat /etc/hostname)" in
  jpi)
    PS1='\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
    ;;
  jsolus)
    . "/usr/share/defaults/etc/profile.d/50-prompt.sh"
    ;;
  jsteam)
    __holo_prompt_command() { return; }
    PS1='\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
    ;;
esac

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

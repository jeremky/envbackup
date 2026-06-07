## ~/.bashrc

# if not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# options
shopt -s checkwinsize

# aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# prompt
case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
  *) ;;
esac

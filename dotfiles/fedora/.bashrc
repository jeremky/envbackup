# ~/.bashrc

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# don't put duplicate lines
HISTCONTROL=ignoreboth

# append to the history file
shopt -s histappend

# for setting history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

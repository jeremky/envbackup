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

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

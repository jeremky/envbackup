#!/bin/bash -e

dir=$(dirname "$0")
dist=$(cat /etc/os-release | grep "^ID" | cut -d= -f2,2)
list="$dir/config/$dist.lst"

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

# Verification du user
if [[ "$USER" = "root" ]]; then
  echo -e "${RED}Ne pas lancer en tant que root !${RESET}"
  exit 0
fi

# Copie des configurations OS
if [[ ! -f $HOME/.bash_aliases || "$1" = "r" ]]; then
  if [[ -d $dir/dotfiles/$dist ]]; then
    cp -Rp $dir/dotfiles/$dist/.* $HOME
    sed -i "s,^scripts=.*,scripts=$(realpath "$0" | rev | cut -d/ -f3- | rev)," ~/.bash_aliases
    echo -e "${GREEN}Restauration effectuée${RESET}"
  fi
else
  for file in $(cat $list | grep -v '#'); do
    if [[ -f $HOME/$file || -d $HOME/$file ]]; then
      rm -fr $dir/dotfiles/$dist/$file
      mkdir -p $(dirname $dir/dotfiles/$dist/$file)
      cp -Rp $HOME/$file $dir/dotfiles/$dist/$file
    fi
  done
  echo -e "${GREEN}Sauvegarde effectuée${RESET}"
fi

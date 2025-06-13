#!/bin/bash -e

dir=$(dirname "$0")
list="$dir/envbackup.lst"

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
  if [[ -d $dir/dotfiles ]]; then
    cp -Rp $dir/dotfiles/.* $HOME
    sed -i "s,^scripts=.*,scripts=$(realpath "$0" | rev | cut -d/ -f3- | rev)," ~/.bash_aliases
    echo -e "${GREEN}Restauration effectuée${RESET}"
  fi
else
  for file in $(cat $list | grep -v '#'); do
    if [[ -f $HOME/$file || -d $HOME/$file ]]; then
      rm -fr $dir/dotfiles/$file
      mkdir -p $(dirname $dir/dotfiles/$file)
      cp -Rp $HOME/$file $dir/dotfiles/$file
    fi
  done
  echo -e "${GREEN}Sauvegarde effectuée${RESET}"
fi

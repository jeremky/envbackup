#!/bin/bash
set -e

dir=$(dirname "$0")
list="$dir/envbackup.lst"

# Verification du user
if [[ "$USER" = "root" ]]; then
  echo "Ne pas lancer en tant que root !"
  exit 0
fi

# Copie des configurations OS
if [[ ! -f $HOME/.bash_aliases || "$1" = "r" ]]; then
  if [[ -d $dir/dotfiles ]]; then
    cp -Rp $dir/dotfiles/.* $HOME
    sed -i "s,^scripts=.*,scripts=$(dirname "$0" | rev | cut -d/ -f2- | rev)," ~/.bash_aliases
    echo "Restauration effectuée"
  fi
else
  for file in $(cat $list | grep -v '#'); do
    if [[ -f $HOME/$file || -d $HOME/$file ]]; then
      rm -fr $dir/dotfiles/$file
      mkdir -p $(dirname $dir/dotfiles/$file)
      cp -Rp $HOME/$file $dir/dotfiles/$file
    fi
  done
  echo "Sauvegarde effectuée"
fi

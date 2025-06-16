#!/bin/bash -e

dir=$(dirname "$0")
dist=$(cat /etc/os-release | grep "^ID=" | cut -d= -f2,2)
list="$dir/config/$dist.lst"

# Messages colorisés
error()    { echo -e "\033[0;31m====> $*\033[0m" ;}
message()  { echo -e "\033[0;32m====> $*\033[0m" ;}
warning()  { echo -e "\033[0;33m====> $*\033[0m" ;}

# Verification du user
if [[ "$USER" = "root" ]]; then
  error "Ne pas lancer en tant que root !"
  exit 1
fi

# Vérification du fichier de list
if [[ ! -f $list ]]; then
  error "Fichier $list absent !"
  exit 1
fi

# Copie des configurations OS
if [[ ! -f $HOME/.bash_aliases || "$1" = "r" ]]; then
  if [[ -d $dir/dotfiles/$dist ]]; then
    cp -Rp $dir/dotfiles/$dist/.* $HOME
    sed -i "s,^scripts=.*,scripts=$(realpath $dir/..)," ~/.bash_aliases
    message "Restauration effectuée"
  fi
else
  for file in $(cat $list | grep -v '#'); do
    if [[ -f $HOME/$file || -d $HOME/$file ]]; then
      rm -fr $dir/dotfiles/$dist/$file
      mkdir -p $(dirname $dir/dotfiles/$dist/$file)
      cp -Rp $HOME/$file $dir/dotfiles/$dist/$file
    fi
  done
  message "Sauvegarde effectuée"
fi

realpath $dir

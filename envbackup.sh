#!/bin/bash -e

dir=$(dirname "$(realpath "$0")")
dist=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')
list="$dir/config/$dist.cfg"

# Messages en couleur
error() { echo -e "\033[0;31m====> $*\033[0m"; }
message() { echo -e "\033[0;32m====> $*\033[0m"; }
warning() { echo -e "\033[0;33m====> $*\033[0m"; }

# Vérification du user
if [[ "$USER" = "root" ]]; then
  error "Ne pas lancer en tant que root !"
  exit 1
fi

# Vérification du fichier de list
if [[ ! -f "$list" ]]; then
  error "Fichier $list absent !"
  exit 1
fi

# Copie des configurations OS
if [[ "$1" = "r" ]]; then
  if [[ -d $dir/dotfiles/$dist ]]; then
    cp -Rp $dir/dotfiles/$dist/.* $HOME
    warning "Restauration effectuée"
  fi
else
  grep -v '^ *#' $list | while read -r line; do
    if [[ -e "$HOME/$line" ]]; then
      rm -fr "$dir/dotfiles/$dist/$line"
      mkdir -p "$(dirname $dir/dotfiles/$dist/$line)"
      cp -Rp "$HOME/$line" "$dir/dotfiles/$dist/$line"
    fi
  done
  message "Sauvegarde effectuée"
fi

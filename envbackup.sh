#!/bin/bash -e

dir=$(dirname "$(realpath "$0")")

# Messages en couleur
error() { echo -e "\033[0;31m====> $*\033[0m"; }
message() { echo -e "\033[0;32m====> $*\033[0m"; }
warning() { echo -e "\033[0;33m====> $*\033[0m"; }

# Vérification de la détection de distribution
if [[ ! -f /etc/os-release ]]; then
  error "Fichier /etc/os-release absent, impossible de détecter la distribution !"
  exit 1
fi
dist=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')
list="$dir/config/$dist.cfg"

# Vérification du user
if [[ "$EUID" -eq 0 ]]; then
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
  if [[ -d "$dir/dotfiles/$dist" ]]; then
    find "$dir/dotfiles/$dist" -mindepth 1 -maxdepth 1 -exec cp -Rp {} "$HOME" \;
    warning "Restauration effectuée"
  fi
else
  while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    mkdir -p "$(dirname "$dir/dotfiles/$dist/$line")"
    cp -Rp "$HOME/$line" "$dir/dotfiles/$dist/$line"
  done <"$list"
  message "Sauvegarde effectuée"
fi

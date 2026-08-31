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
  while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    src="$dir/dotfiles/$line"
    [[ -e "$src" ]] || continue
    mkdir -p "$(dirname "$HOME/$line")"
    cp -Rp "$src" "$HOME/$line"
  done <"$list"
  warning "Restauration effectuée"
else
  while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    if [[ ! -e "$HOME/$line" ]]; then
      warning "Fichier $HOME/$line non présent"
      continue
    fi
    dest="$dir/dotfiles/$line"
    mkdir -p "$(dirname "$dest")"
    cp -Rp "$HOME/$line" "$dest"
  done <"$list"
  message "Sauvegarde effectuée"
fi

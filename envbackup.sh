#!/bin/bash -e

dir=$(dirname "$(realpath "$0")")

# Messages en couleur
error() { echo -e "\033[0;31m❯ $*\033[0m"; }
message() { echo -e "\033[0;36m──────────\033[0m\n\033[0;32m❯ $*\033[0m"; }
warning() { echo -e "\033[0;33m❯ $*\033[0m\n\033[0;36m──────────\033[0m"; }

# Vérification de la détection de l'OS/distribution
if [[ "$(uname -s)" == "Darwin" ]]; then
  ID="macos"
else
  if ! . /etc/os-release 2>/dev/null; then
    error "Fichier /etc/os-release absent, impossible de détecter la distribution !"
    exit 1
  fi
fi
list="$dir/config/$ID.cfg"

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

# Sauvegarde / Restauration
copy() {
  local src="$1" dest="$2" missing="$3"
  if [[ ! -e "$src" ]]; then
    [[ "$missing" == 1 ]] && warning "Fichier $src non présent"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  cp -Rpv "$src" "$dest"
}

# Exécution
echo
warning "Synchronisation des fichiers"
while read -r line; do
  [[ -z "$line" || "$line" == \#* ]] && continue
  dotfile="$dir/dotfiles/$line"
  home="$HOME/$line"
  if [[ "$1" = "r" ]]; then
    copy "$dotfile" "$home" 0
  else
    copy "$home" "$dotfile" 1
  fi
done <"$list"
message "Opération terminée"
echo

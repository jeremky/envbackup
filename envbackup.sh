#!/bin/bash -e

dir=$(dirname "$(realpath "$0")")

# Colored messages
error() { echo -e "\033[0;31m❯ $*\033[0m"; }
message() { echo -e "\033[0;36m──────────\033[0m\n\033[0;32m❯ $*\033[0m"; }
warning() { echo -e "\033[0;33m❯ $*\033[0m\n\033[0;36m──────────\033[0m"; }

# Detect OS/distribution
if [[ "$(uname -s)" == "Darwin" ]]; then
  ID="macos"
else
  if ! . /etc/os-release 2>/dev/null; then
    error "File /etc/os-release not found, unable to detect the distribution!"
    exit 1
  fi
fi
list="$dir/config/$ID.cfg"

# Check user
if [[ "$EUID" -eq 0 ]]; then
  error "Do not run as root!"
  exit 1
fi

# Check list file
if [[ ! -f "$list" ]]; then
  error "File $list not found!"
  exit 1
fi

# Backup / Restore
copy() {
  local src="$1" dest="$2" missing="$3"
  if [[ ! -e "$src" ]]; then
    [[ "$missing" == 1 ]] && error "File $src not found"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  cp -Rpv "$src" "$dest"
}

# Execution
echo
warning "Syncing files"
while read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" == \#* ]] && continue
  dotfile="$dir/dotfiles/$line"
  home="$HOME/$line"
  if [[ "$1" = "r" ]]; then
    copy "$dotfile" "$home" 0
  else
    copy "$home" "$dotfile" 1
  fi
done <"$list"
message "Operation complete"
echo

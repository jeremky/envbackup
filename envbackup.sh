#!/bin/dash
set -e

dir=$(dirname "$0")

## Verification du user
if [ "$USER" = "root" ] ; then
  echo "Ne pas lancer en tant que root !"
  exit 0
fi

## Copie des configurations OS
if [ ! -f $HOME/.*_aliases ] || [ "$1" = "r" ] ; then
  if [ -d $dir/dotfiles ] ; then
    cd $dir/dotfiles
    cp -Rp $dir/dotfiles $HOME
    echo "Restauration effectuée"
  fi
else
  cd $HOME
  list="$dir/$(basename -s .sh $0).lst"
  for file in $(cat $list | grep -v '#') ; do
    if [ -f $HOME/$file ] || [ -d $HOME/$file ] ; then
      cp -Rp $file $dir/dotfiles
    fi
  done
  echo "Sauvegarde effectuée"
fi

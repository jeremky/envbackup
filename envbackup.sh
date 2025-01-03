#!/bin/dash

## Variables
dir=$(dirname "$0")
config="$dir/$(basename -s .sh $0).cfg"

## Verification
verification_user() {
  if [ "$USER" = "root" ] ; then
    echo "Ne pas lancer en tant que root !"
    exit 0
  fi
}

restauration_fichiers() {
  if [ -d $dir/envfiles ] ; then
    cd $dir/envfiles
    for file in "$(ls -A)" ; do
      cp -Rp $file $HOME
    done
    echo "Restauration effectuée"
    exit 0
  fi
}

sauvegarde_fichiers() {
  cd $HOME
  for file in $(cat $config | grep -v '#') ; do
    if [ -f $HOME/$file ] || [ -d $HOME/$file ] ; then
      cp -Rp $file $dir/envfiles
    fi
  done
  echo "Sauvegarde effectuée"
  exit 0
}

## Déroulement du script
main () {
  verification_user
  if [ ! -f $HOME/.*_aliases ] || [ "$1" = "r" ] ; then
    restauration_fichiers
  else
    sauvegarde_fichiers
  fi
}

main $1

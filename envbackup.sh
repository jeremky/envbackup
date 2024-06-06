#!/bin/dash

## Variables
dir=$(dirname "$0")
config="$dir/$(basename -s .sh $0).cfg"

## Verification
if [ "$USER" = "root" ] ; then
    echo "Ne pas lancer en tant que root !"
    exit 0
fi

## Copie des configurations OS
if [ ! -f $HOME/.*_aliases ] || [ "$1" = "r" ] ; then
    if [ -d $dir/files ] ; then
        cd $dir/files
        for file in "$(ls -A)" ; do
            cp -Rp $file $HOME
        done
        echo "Restauration effectuée"
            exit 0
    fi
else
    cd $HOME
    for file in $(cat $config | grep -v '#') ; do
        if [ -f $HOME/$file ] || [ -d $HOME/$file ] ; then
            cp -Rp $file $dir/files
        fi
    done
    echo "Sauvegarde effectuée"
    exit 0
fi

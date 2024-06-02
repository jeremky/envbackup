#!/bin/dash

## Variables
dir=$(dirname "$0")
config="$dir/$(basename -s .sh $0).cfg"
targz="$dir/$(basename -s .sh $0).tar.gz"

## Verification
if [ "$USER" = "root" ] ; then
    echo "Ne pas lancer en tant que root !"
    exit 0
fi

## Copie des configurations OS
if [ ! -f $HOME/.*_aliases ] || [ "$1" = "r" ] ; then
    if [ -f $targz ] ; then
        cd $HOME && tar xzf $targz
    fi
else
    cd $HOME
    cp /dev/null $dir/.envbackup.lst
    for file in $(cat $config | grep -v '#') ; do
        if [ -f $HOME/$file ] || [ -d $HOME/$file ] ; then
            echo $file >> $dir/.envbackup.lst
            cp -Rp $file $dir/files
        fi
    done
    tar czvf $targz $(cat $dir/.envbackup.lst)
fi

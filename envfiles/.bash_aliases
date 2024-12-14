###### Aliases ######

## Variables
export LANG=fr_FR.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export EDITOR=vi
export VISUAL=$EDITOR

## Tweaks
bind 'set completion-ignore-case on'

## Sudo
if [ -f /usr/bin/sudo ] && [ "$USER" != "root" ] ; then
    alias su='sudo -s'
    sudo=sudo
else
    alias su='su -'
fi

## Aliases
alias l='ls -lh'
alias la='ls -lhA'
alias lr='ls -lLhR'
alias lra='ls -lhRA'
alias lrt='ls -lLhrt'
alias lart='ls -lLhArt'
alias grep='grep -i --color=auto'
alias zgrep='zgrep -i --color=auto'
alias df='df -h -x overlay -x tmpfs -x devtmpfs'
alias psp='ps -eaf | grep -v grep | grep'
alias iostat='iostat -m --human'
alias ifconfig='ip -br -c addr | grep -v lo'
alias netstat='ss -lpn'
alias ss='ss -tunlH'
alias ssp='ss -tunl | grep'
alias md5='md5sum <<<'
alias pubip='curl -s -4 ipecho.net/plain ; echo'
alias wget='wget --no-check-certificate'
alias halt='$sudo halt -p'
alias reboot='$sudo reboot'

## Apt
alias apt='$sudo apt'
alias upgrade='$sudo apt update && $sudo apt full-upgrade && $sudo apt -y autoremove'

## Ssh
alias genkey='ssh-keygen -t ed25519 -a 100'
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100'
alias copykey='ssh-copy-id'

## Vi
if [ -f /usr/bin/nvim ] ; then
    alias vi='nvim -nO'
    alias view='nvim -nRO'
elif [ -f /usr/bin/vim ] ; then
    alias vi='vim -nO'
    alias view='vim -nRO'
fi

## Top
if [ -f /usr/bin/htop ] ; then
    alias top='htop'
    alias topc='htop -C'
fi

## Ncdu
if [ -f /usr/bin/ncdu ] ; then
    alias ncdu='ncdu --color dark'
fi

## Ufw
if [ -f /usr/sbin/ufw ] ; then
    alias ufw='$sudo ufw'
    alias ufws='$sudo ufw status numbered'
fi

## Diff
if [ -f /usr/bin/colordiff ] ; then
    alias diff='colordiff'
fi

## Df
if [ -f /usr/bin/duf ] ; then
    alias df='duf /'
fi

## Grep
if [ -f /usr/bin/rg ] ; then
    alias rg='rg -i'
fi

## Podman
if [ -f /usr/bin/podman ] ; then
    alias docker='$sudo podman'
    alias docker-compose='$sudo podman-compose'
    alias podman='$sudo podman'
    alias podman-compose='$sudo podman-compose'
fi

## Lazydocker
if [ -f /usr/bin/lazydocker ] ; then
    lzd() { if [ ! -h /var/run/docker.sock ] ; then $sudo ln -s /var/run/podman/podman.sock /var/run/docker.sock ; fi ; $sudo lazydocker ;}
fi

## Fonctions
newuser() { $sudo adduser --no-create-home -q --disabled-password --comment "" $1 ; echo "Utilisateur $1 créé. ID : $(id -u $1)" ;}

cpsave() { cp -Rp $1 "$(echo $1 | cut -d '/' -f 1)".old ;}

zip() { /usr/bin/zip -r "$(echo "$1" | cut -d '/' -f 1)".zip $* ;}

tarc() { for file in $* ; do tar czvf "$(echo $file | cut -d '/' -f 1)".tar.gz $file ; done ;}
tarx() { for file in $* ; do tar xzvf $file ; done ;}

jsed() { sed -i "s|$1|$2|g" $3 ;}

## Scripts
scripts=/home/jeremky/scripts
if [ -d $scripts ] ; then
    for i in $(ls $scripts) ; do
        if [ -f $scripts/$i/$i.sh ] ; then
            alias $i=''$scripts'/'$i'/'$i'.sh'
        fi
    done
fi

## Tmux
if [ -f /usr/bin/tmux ] ; then
    alias tmux='tmux attach || tmux new'
    #if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [ -z "$(pgrep tmux)" ] ; then
    #    exec tmux new-session -A -s main
    #fi
fi

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
alias upgrade='$sudo apt update && $sudo apt full-upgrade && $sudo apt -y autoremove'
alias wget='wget --no-check-certificate'
alias halt='$sudo halt -p'

## Ssh
alias genkey='ssh-keygen -t ed25519 -a 100'
alias genkeyrsa='ssh-keygen -t rsa -b 4096 -a 100'
alias copykey='ssh-copy-id'

## Vi
if [ -f /usr/bin/vim ] ; then
    alias vi='vi -nO'
    alias view='vi -nRO'
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
    alias df='duf --hide special'
fi

## Grep
if [ -f /usr/bin/rg ] ; then
    alias rg='rg -i'
fi

## Docker
if [ -f /usr/bin/docker ] ; then
    alias docker='$sudo docker'
    alias peer='docker exec -it wireguard /app/show-peer $1'
    alias mccons='docker exec -it mcserver rcon-cli'
    alias ncclean='$sudo cp /dev/null /opt/nextcloud/data/nextcloud.log'
fi

## Lazydocker
if [ -f /usr/bin/lazydocker ] ; then
    alias lzd='$sudo lazydocker'
fi

## Fonctions
newuser() { $sudo adduser --no-create-home -q --disabled-password --gecos "" $1 ; echo "Utilisateur $1 créé. ID : $(id -u $1)" ;}
cpsave() { cp -Rp $1 "$(echo $1 | cut -d '/' -f 1)".old ;}
zip() { /usr/bin/zip -r "$(echo "$1" | rev | cut -d '/' -f 1 | cut -d '.' -f 2- | rev)".zip $* ;}

tarc() { for file in $* ; do tar czvf "$(echo $file | cut -d '/' -f 1)".tar.gz $file ; done ;}
tarx() { for file in $* ; do tar xzvf $file ; done ;}

gpgc() { gpg -c "$1" ;}
gpgd() { for file in $* ; do gpg -o "$(basename "$file" .gpg)" -d "$file" ; done ;}

gencert() { read -p "Adresse mail : " mail ; $sudo certbot certonly --standalone --preferred-challenges http --email $mail -d $1 ;}
rencert() { $sudo certbot -q renew ;}

## Scripts
scripts=/home/jeremky/scripts
if [ -d $scripts ] ; then
    for i in $(ls $scripts) ; do
        if [ -f $scripts/$i/$i.sh ] ; then
            alias $i=''$scripts'/'$i'/'$i'.sh'
        fi
    done
fi

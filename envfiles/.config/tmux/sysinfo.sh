#!/bin/bash

## Récupération des infos
ETH=ens3

# CPU
CPU=$(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf("%02d", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5))}')

# RAM
MEM=$(free | grep Mem | awk '{printf("%02d",  $3/$2 * 100.0)}')

# RESEAU
R1=$(cat /sys/class/net/$ETH/statistics/rx_bytes)
T1=$(cat /sys/class/net/$ETH/statistics/tx_bytes)
sleep 1
R2=$(cat /sys/class/net/$ETH/statistics/rx_bytes)
T2=$(cat /sys/class/net/$ETH/statistics/tx_bytes)
TBPS=$(expr $T2 - $T1)
RBPS=$(expr $R2 - $R1)
TKBPS=$(expr $TBPS / 1024)
RKBPS=$(expr $RBPS / 1024)

## Affichage du résultat
printf "CPU: %.f%% | MEM: %.f%% | NET: ↓%dK ↑%dK " $CPU $MEM $RKBPS $TKBPS

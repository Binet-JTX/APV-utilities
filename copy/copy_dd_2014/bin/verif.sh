#!/bin/bash
# $1 is key $2 disk
APV_HOST=`hostname -a`
touch ~/apv/logs/verif/$APV_HOST.$1.start
sudo /usr/bin/sha256sum -b /dev/$1 2>~/apv/logs/verif/$APV_HOST.$1.err.log | tee ~/apv/logs/verif/$APV_HOST.$1.sha256sum | awk '{print $1}' | diff -q -  ~/apv.sha256sum > ~/apv/logs/verif/$APV_HOST.$1.diff && touch  ~/apv/logs/verif/$APV_HOST.$1.stop || touch ~/apv/logs/verif/$APV_HOST.$1.fail

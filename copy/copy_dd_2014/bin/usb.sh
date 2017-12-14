#!/bin/bash
# $1 is key $2 disk
APV_HOST=`hostname -a`
touch ~/apv/logs/copy/$APV_HOST.$1.start
sudo /bin/dd if=/tmp/disk$2.dd of=/dev/$1 bs=4K 2>> ~/apv/logs/copy/$APV_HOST.$1.dd.err.log >> ~/apv/logs/copy/$APV_HOST.$1.dd.log && sudo /usr/bin/sha256sum -b /dev/$1 | tee ~/apv/logs/copy/$APV_HOST.$1.sha256sum | awk '{print $1}' | diff -q -  ~/apv.sha256sum > ~/apv/logs/copy/$APV_HOST.$1.diff && touch  ~/apv/logs/copy/$APV_HOST.$1.stop || touch ~/apv/logs/copy/$APV_HOST.$1.fail

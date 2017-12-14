#!/bin/bash

name=$1
cle=$2

ip=$(hostname -i)

path=/tmp/apv_1/

if [ $cle = sdb ]
then
	/users/eleves-b/x2013/augustin.lenormand/rsync/rsync-3.1.2/rsync -rh --partial --info=progress2  $path /tmp/diskA
else
        /users/eleves-b/x2013/augustin.lenormand/rsync/rsync-3.1.2/rsync -rh --partial --info=progress2 -h $path /tmp/diskB
fi

sleep 10

sudo /bin/umount /tmp/diskA
sudo /bin/umount /tmp/diskB

#!/bin/bash

name=$(hostname -a)
c="0"
mkdir /tmp/diskA
mkdir /tmp/diskB 

if [ -e /dev/sdb ]
then 
	sudo /sbin/mkdosfs -F 32 -I  /dev/sdb1
	sudo /bin/mount /dev/sdb1 /tmp/diskA -o umask=000
	echo "mount sdb ok"
	#screen -dmS sdb copyCle.sh $name sdb
	screen -dmS sdb /users/eleves-b/x2013/augustin.lenormand/APV/scripts/copyCle.sh $name sdb
	c=$[$c+1];
fi

if [ -e /dev/sdc ]
then
	sudo /sbin/mkdosfs -F 32 -I  /dev/sdc1
	sudo /bin/mount /dev/sdc1 /tmp/diskB -o umask=000
	echo "mount sdc ok"
	#screen -dmS sdc copyCle.sh $name sdc
	screen -dmS sdc /users/eleves-b/x2013/augustin.lenormand/APV/scripts/copyCle.sh $name sdc
fi


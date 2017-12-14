#!/bin/bash

name=$(hostname -a)
echo $name >> /users/eleves-b/x2013/augustin.lenormand/APV/summary
c="0"
mkdir /tmp/diskA
mkdir /tmp/diskB 

if [ -e /dev/sdb ]
then 
	sudo /sbin/mkdosfs -F 32 -I  /dev/sdb
	sudo /bin/mount /dev/sdb1 /tmp/diskA -o umask=000
	screen -dmS sdb copyCle.sh $name
	echo "    sdb" >> /users/eleves-b/x2013/augustin.lenormand/APV/summary
	c=$[$c+1];
fi

if [ -e /dev/sdc ]
then
	sudo /sbin/mkdosfs -F 32 -I  /dev/sdc
	sudo /bin/mount /dev/sdb1 /tmp/diskA -o umask=000
	screen -dmS sdc copyCle.sh $name
	echo "    sdc" >> /users/eleves-b/x2013/augustin.lenormand/APV/summary
fi

if [ $c -lt 1 ] 
then
	cp summary summary.tmp
	head -n -1 summary.tmp > summary
	rm -f summary.tmp
fi	

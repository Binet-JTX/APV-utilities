#!/bin/bash


mkdir /tmp/diskA
mkdir /tmp/diskB 

if [ -e /dev/sdb ]
then 
	sudo /sbin/mkdosfs -F 32 -I  /dev/sdb1
	sudo /bin/mount /dev/sdb1 /tmp/diskA -o umask=000
fi

if [ -e /dev/sdc ]
then
	sudo /sbin/mkdosfs -F 32 -I  /dev/sdc1
	sudo /bin/mount /dev/sdc1 /tmp/diskB -o umask=000
fi

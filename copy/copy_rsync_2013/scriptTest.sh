#!/bin/bash

# scriptMstr.sh

c="0"
b="0"
while [ $c -lt 169 ] ; do
        #echo $c;
        b=$[$b+1]
        addrIp=$(sed -n ''$b'p' listeIP | awk '{print $1}');
        #echo $addrIp;
        ssh $addrIp 'screen -d -m /users/eleves-b/x2013/augustin.lenormand/APV/scripts/APV_test1.sh  '
        #echo "Et un de plus!";
        c=$[$c+1];
done


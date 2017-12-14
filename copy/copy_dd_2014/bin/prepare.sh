APV_HOST=`hostname -a`
touch ~/apv/logs/prepare/$APV_HOST.start
ln /tmp/APV2014.iso /tmp/diska.dd
cp /tmp/APV2014.iso /tmp/diskb.dd && touch ~/apv/logs/prepare/$APV_HOST.stop || touch ~/apv/logs/prepare/$APV_HOST.failed

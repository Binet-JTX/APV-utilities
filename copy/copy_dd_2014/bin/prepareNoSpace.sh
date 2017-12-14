APV_HOST=`hostname -a`
touch ~/apv/logs/prepare/$APV_HOST.start
mv ~/apv/logs/prepare/$APV_HOST.failed ~/apv/logs/prepare/$APV_HOST.failed.old
rm -f /tmp/diskb.dd
ln /tmp/APV2014.iso /tmp/diska.dd && ln /tmp/APV2014.iso /tmp/diskb.dd && touch ~/apv/logs/prepare/$APV_HOST.stop || touch ~/apv/logs/prepare/$APV_HOST.failed

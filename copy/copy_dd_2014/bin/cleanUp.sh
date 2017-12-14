APV_HOST=`hostname -a`
touch ~/apv/logs/clean/$APV_HOST.start
rm -f /tmp/APV2014.iso /tmp/diska.dd /tmp/diskb.dd && touch ~/apv/logs/clean/$APV_HOST.stop || touch ~/apv/logs/clean/$APV_HOST.failed

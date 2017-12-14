echo usb copy `hostname -a` ...
tmux new-session -d -s $1 "~/apv/bin/usb.sh ${1} a"
echo start $1


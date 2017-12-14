echo usb copy `hostname -a` ...
tmux new-session -d -s sdb "~/apv/bin/usb.sh sdb b"
echo start sdb
tmux new-session -d -s sda "~/apv/bin/usb.sh sdc a"
echo start sdc


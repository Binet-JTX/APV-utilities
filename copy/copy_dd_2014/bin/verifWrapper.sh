echo usb copy `hostname -a` ...
tmux new-session -d -s sdb "~/apv/bin/verif.sh sdb b"
echo start sdb
tmux new-session -d -s sda "~/apv/bin/verif.sh sdc a"
echo start sdc


echo prepare `hostname -a`
tmux new-session -d -s prepare ~/apv/bin/prepare.sh

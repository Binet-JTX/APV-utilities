echo prepare `hostname -a`
tmux new-session -d -s prepare ~/apv/bin/prepareNoSpace.sh

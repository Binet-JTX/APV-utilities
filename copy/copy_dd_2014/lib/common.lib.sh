
#tmux back_ground name cmd
tmux_background(){
    tmux new-session -d -s $1 "$2"
}

export APV_USER=guillaume.didier
cat $1 | xargs -I {} ssh $APV_USER@{} ~/apv/bin/prepareWrapper.sh #"tmux new-session -d -s prepare ~/apv/bin/prepare.sh"


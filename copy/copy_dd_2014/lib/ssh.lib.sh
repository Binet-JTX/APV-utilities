remote_cmd(){
    ssh $1 "${2}"
}


#multi_ssh ordis.txt cmd
multi_ssh(){
    cat $1 | xargs -I {} ./remote_cmd.sh $APV_USER@{} "$2"
}



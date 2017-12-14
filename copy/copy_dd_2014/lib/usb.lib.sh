BS="4K"

TEST=1

# dd_cmd diskname sourcename
real_dd_cmd(){
    sudo dd if=/dev/$1 of=/tmp/$2 bs=$BS
}

pseudo_dd_cmd(){
    echo sudo dd if=/dev/$1 of=/tmp/$2 bs=$BS
}

dd_cmd(){
    if [ $TEST -eq 0 ] ; then
        real_dd_cmd $* ;
    else
       pseudo_dd_cmd $* ;
    fi
}

# checksum disk reference_checksum
pseudo_compute_checksum(){
    echo "fefaegfougyazeofugy"
}

real_compute_checksum(){
    sudo sha256sum -b /dev/$1
}
compute_checksum(){
    if [ $TEST -eq 0 ] ; then
        real_compute_checksum $* ;
    else
       pseudo_compute_checksum $* ;
    fi
}



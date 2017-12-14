SCRIPTDIR=`dirname $0`
export APVROOT=`$SCRIPTDIR/get_root.sh`
echo $APVROOT


source $APVROOT/lib/common.lib.sh
tmux_background test "echo blah; sleep 100; echo foobar; echo blah>blah.txt"

STARTED=`ls $1 | grep start| wc -l`
STOP=`ls $1 | grep stop | wc -l`
FAILED=`ls $1 | grep fail | wc -l`
echo started: $STARTED finished: $STOP failed: $FAILED

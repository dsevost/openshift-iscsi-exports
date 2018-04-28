#!/bin/bash

. $(dirname $0)/env.sh || exit 1

for v in ${VOL_PREFIX}* ; do
    name=$(basename $v)
    for w in ${INITIATOR_NAMES} ; do
#	echo \
	targetcli /iscsi/${TARGET_WWN_PREFIX}.$(hostname -s):$name/tpg1/acls create wwn=$w
    done
done

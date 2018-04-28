#!/bin/bash

. $(dirname $0)/env.sh || exit 1

for v in ${VOL_PREFIX}* ; do
    name=$(basename $v)
#    echo \
    targetcli /iscsi create wwn=${TARGET_WWN_PREFIX}.$(hostname -s):$name
done

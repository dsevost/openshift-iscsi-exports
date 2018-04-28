#!/bin/bash

. $(dirname $0)/env.sh || exit 1

for v in ${VOL_PREFIX}* ; do
    name=$(basename $v)
#    echo \
    targetcli /backstores/block create $name dev=$v
done

#!/bin/bash

. $(dirname $0)/env.sh || exit 1

i=0
for s in ${SIZES} ; do
    case $s in
	128M)
	    name=01
	    count=5
	    ;;
	256M)
	    name=02
	    count=5
	    ;;
	512M)
	    name=05
	    count=5
	    ;;
	1G)
	    name=1
	    count=5
	    ;;
	3G)
	    name=3
	    count=3
	    ;;
	6G)
	    name=6
	    count=3
	    ;;
	*)
	    die "Size $s not supported yet"
	    ;;
    esac
    cmd="{1..$count}"
    for c in $(eval echo $cmd) ; do
	i=$((i + 1))
	n=${name}-$(printf "%0.3i" $i)
        create_backing_store $n $s
    done
done

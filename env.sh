#!/bin/bash

BACKING_STORE_TYPE=lvm
BACKING_STORE_TYPE=zfs

INITIATOR_NAMES="\
iqn.1994-05.com.redhat:48382391af \
iqn.1994-05.com.redhat:3a62c87883f8 \
iqn.1994-05.com.redhat:d1cd629ab0 \
iqn.1994-05.com.redhat:b71236a1999d \
iqn.1994-05.com.redhat:81a7199e954 \
"

SIZES="128M 256M 512M 1G 3G 6G"
STORAGE_CLASS_NAME=example-iscsi

TARGET=172.19.1.241
TARGET_WWN_PREFIX=iqn.2003-01.org.linux-iscsi

VOL_PREFIX=/dev/vg_data/ipv-
VOL_PREFIX=/dev/zvol/store01/volumes/iscsi/ipv-

function msg() {
    echo $*
}

function die() {
    local msg=$1
    local err_core=${2:-1}

    msg $msg
    exit $error_code
}

function create_backing_store() {
    local name_suffix=$1
    local size=$2
    local name_prefix=$(basename $VOL_PREFIX)

    case $BACKING_STORE_TYPE in
	lvm)
#	    echo \
	    lvcreate -n ${name_prefix}${name_suffix} -L $size $(dirname $VOL_PREFIX)
	;;
	zfs)
	    zfsvol=$(echo $VOL_PREFIX | sed 's|/dev/zvol/||')
#	    echo \
	    zfs create -s -o volblocksize=4k -V $size ${zfsvol}${name_suffix}
	;;
	*)
	    die "Backing store type $BACKING_STORE_TYPE is not recognized"
	;;
    esac
}

#!/bin/bash

. $(dirname $0)/env.sh || exit 1

set -e

targets=$(iscsiadm -m discovery -t sendtargets -p ${TARGET}:3260 | awk '{ print $2; }')

echo > pv-list.yaml

for t in $targets ; do
    name=$(echo $t | awk -F: '{ print $2; }')
    size=$(echo $name | awk -F- '{ print $2; }')
    case $size in
	01)
	    size="128Mi"
	    ;;
	02)
	    size="256Mi"
	    ;;
	05)
	    size="512Mi"
	    ;;
	1|3|6)
	    size="${size}Gi"
	    ;;
	*)
	    die "Cannt recognize size for target name $name"
	    ;;
    esac
    cat << EOF >> pv-list.yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: $name
spec:
  capacity:
    storage: $size
  accessModes:
  - ReadWriteOnce
  iscsi:
    targetPortal: ${TARGET}:3260
#    portals: ['10.16.154.82:3260', '10.16.154.83:3260']
    iqn: $t
    lun: 0
    fsType: xfs
    readOnly: false
#    chapAuthDiscovery: true
#    chapAuthSession: true
#    secretRef:
#      name: chap-secret
  storageClassName: ${STORAGE_CLASS_NAME}
EOF

done
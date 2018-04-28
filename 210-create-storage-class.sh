#!/bin/bash

. $(dirname $0)/env.sh || exit 1

cat << EOF > storage-class.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1beta1
metadata:
  name: ${STORAGE_CLASS_NAME}
provisioner: no-provisioning
parameters:
EOF

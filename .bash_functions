#!/bin/bash

function kns() {
  #echo "kns $@"
  if [ $# -lt 1 ]
  then
    echo "current storj k8s namespace: $K8_STORJ_NS"
  else
    kns
    export K8_STORJ_NS="storj-$1"
    echo "new storj k8s namespace: $K8_STORJ_NS"
  fi
}
export -f kns

function kube() {
  kubectl --namespace $K8_STORJ_NS $@
}
export -f kube

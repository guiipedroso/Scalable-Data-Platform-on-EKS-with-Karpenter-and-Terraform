#!/bin/bash

set -euo pipefail

: "${REGION:?REGION env var must be set}"
: "${CLUSTER_NAME:?CLUSTER_NAME env var must be set}"
: "${KARPENTER_NODE_ROLE:?KARPENTER_NODE_ROLE env var must be set}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_NODE_CLASS=$(mktemp /tmp/karpenter-node-class.XXXXXX.yml)

function cleanup() {
    rm -f "$TMP_NODE_CLASS"
}
trap cleanup EXIT

function enableKubernetesClusterConnection() {
    aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER_NAME"
}

function renderKarpenterNodeClass() {
    sed \
        -e "s|\${CLUSTER_NAME}|$CLUSTER_NAME|g" \
        -e "s|\${KARPENTER_NODE_ROLE}|$KARPENTER_NODE_ROLE|g" \
        "$SCRIPT_DIR/../resources/karpenter-node-class.yml" > "$TMP_NODE_CLASS"
}

function createKarpenterResources() {
    kubectl apply -f "$TMP_NODE_CLASS"
    kubectl apply -f "$SCRIPT_DIR/../resources/karpenter-node-pool.yml"
}

enableKubernetesClusterConnection
renderKarpenterNodeClass
createKarpenterResources

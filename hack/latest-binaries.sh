#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ "$#" -ne 1 ]; then
  echo "usage: $0 KUBERNETES_VERSION"
  exit 1
fi

K8S_VERSION="${1}"

LATEST_K8S_VERSION=$(aws s3 ls "s3://amazon-eks/${K8S_VERSION}" | awk '{print $2}' | rev | cut -c2- | rev | sort -V -r | head -n1)

LATEST_DATE=$(aws s3 ls "s3://amazon-eks/$LATEST_K8S_VERSION/" | awk '{print $2}' | rev | cut -c2- | rev | sort -r | head -n1)

echo "kubernetes_version=${LATEST_K8S_VERSION} kubernetes_build_date=${LATEST_DATE}"

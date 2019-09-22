#!/usr/bin/env bash

set -e

rm -rf packages/ || true
mkdir -p packages/
for v in 0.1.0 0.2.0 0.2.1 0.2.2 0.3.0 0.4.0; do
  git checkout prometheus-process-exporter-$v
  helm package charts/prometheus-process-exporter --destination packages
done
git checkout master

#!/bin/bash
set -e -o pipefail

IFS=$'\n' versions=( $(grep -v -e '^#' build/versions.txt) )
for version in "${versions[@]}"; do
  build/build.sh --version "$version" $@
done


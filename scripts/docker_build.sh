#!/usr/bin/env sh

set -e

docker build -t dexonfoundation/dsolc:build -f scripts/Dockerfile .
tmp_container=$(docker create dexonfoundation/dsolc:build sh)
mkdir -p upload
docker cp ${tmp_container}:/usr/bin/solc upload/solc-static-linux

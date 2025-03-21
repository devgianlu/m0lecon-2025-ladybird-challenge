#!/usr/bin/env bash

set -ex

docker build -t ladybird -f Dockerfile.build .
container=$(docker run --rm -q -d ladybird)

rm -rf ./build
docker cp "$container:/home/ladybird/out/" ./build

docker stop -t0 "$container"

patchelf --set-rpath '$ORIGIN/../vcpkg:$ORIGIN/../lib:' ./build/bin/js
patchelf --set-rpath '$ORIGIN/../vcpkg:$ORIGIN:' ./build/lib/*.so
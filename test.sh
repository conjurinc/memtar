#!/bin/bash -eu

docker build -f Dockerfile.test -t memtar_test .
docker run --rm -v "$(pwd):/src" memtar_test rake spec

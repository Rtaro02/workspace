#!/bin/bash

if [ $# != 3 ]; then
    echo 引数エラー: $*
    exit 1
fi

docker build \
    --build-arg ROOT_PASSWORD=$1 \
    --build-arg GIT_USER=$2 \
    --build-arg GIT_PASSWORD=$3 \
    -t my-workspace:latest .


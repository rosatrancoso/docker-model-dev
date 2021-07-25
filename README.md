# model-dev

## Run as user

    export UID=`id -u`; export GID=`id -g`
    mkdir tmp

    docker run -ti --user $UID:$GID -v $PWD/tmp/:/xxx ubuntu:latest bash

## Dockerfile

COPY takes in a src and destination. It only lets you copy in a local file or directory from your host (the machine building the Docker image) into the Docker image itself.

ADD lets you do that too, but it also supports 2 other sources. First, you can use a URL instead of a local file / directory. Secondly, you can extract a tar file from the source directly into the destination.



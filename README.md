# model-dev

    export UID=`id -u`; export GID=`id -g`
    mkdir tmp

    docker run -ti --user $UID:$GID -v $PWD/tmp/:/xxx ubuntu:latest bash


FROM centos:centos7

RUN yum -y install epel-release &&\
    yum -y install git vim sudo tar unzip wget python-pip python-devel \
                   gcc gfortran &&\
    yum -y update &&\
    yum clean all

ENV HOME /home/developer 
ENV REPOS /source

# Replace 1001 with your user / group id
RUN export uid=1001 gid=1001 && \
    mkdir -p $HOME && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R $HOME


RUN mkdir $REPOS &&\
    chown -R developer:developer $REPOS

USER developer

# do this outside because too slow
RUN git clone --depth 1 https://github.com/wrf-model/WRF $REPOS/wrf &&\
    cd $REPOS/wrf &&\
    git fetch --tags &&\
    latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) &&\
    git checkout -b $latestTag $latestTag




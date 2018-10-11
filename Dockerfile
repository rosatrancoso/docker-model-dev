FROM centos:centos7

RUN yum -y install epel-release &&\
    yum -y install git vim sudo tar unzip wget python-pip python-devel \
                   gcc gcc-gfortran gcc-c++ glibc-static zlib-static \
                   man make  zlib-devel netcdf-devel netcdf-fortran &&\
    yum -y update &&\
    yum clean all


ENV USER user
ENV HOME /home/$USER
ENV REPOS /source

# Replace 1001 with your user / group id
RUN export uid=1001 && \
    adduser --uid $uid $USER &&\
    echo "$USER ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

RUN su - $USER -c "touch mine"
CMD ["su", "-", $USER, "-c", "/bin/bash"]

RUN mkdir $REPOS &&\
    chown -R $USER:$USER $REPOS

USER $USER

# RUN sudo yum -y remove mpich

RUN echo "Installing mpich..." &&\
    cd /tmp &&\
    wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz &&\
    tar zxvf mpich-3.2.tar.gz &&\
    cd mpich-3.2 &&\
    ./configure 2>&1 | tee configure.log &&\
    make 2>&1 | tee make.log &&\
    make check 2>&1 | tee make_check.log &&\
    make install 2>&1 | tee make_install.log &&\
    cd ../



# do this outside because too slow
# RUN git clone --depth 1 https://github.com/wrf-model/WRF $REPOS/wrf &&\
#     cd $REPOS/wrf &&\
#     git fetch --tags &&\
#     latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) &&\
#     git checkout -b $latestTag $latestTag

# latesttag=$(git describe --tags)
# echo checking out ${latesttag}
# git checkout ${latesttag}


# RUN git clone git@github.com:NCAR/wrf_hydro_nwm_public.git $REPOS/wrf-dev/wrf_hydro_nwm_public &&\
#     cd $REPOS/wrf-dev/wrf_hydro_nwm_public &&\
#     latesttag=$(git describe --tags) &&\
#     echo "checking out ${latesttag}" &&\
#     git checkout ${latesttag}






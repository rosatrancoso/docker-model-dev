# hysplit.v5.0.0_Ubuntu needs GLIBC_2.29
# ubuntu 18 only has glibc 2.27 (see ldd --version)
FROM ubuntu:20.10
LABEL maintainer="rosa.trancoso@metservice.com"

ENV SOURCE_DIR=/source
RUN mkdir $SOURCE_DIR

################################
### Install system libraries ###
################################


    
ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y \
    cmake make autoconf automake \
    gcc g++ gfortran \
    zlib1g-dev libhdf5-dev libnetcdf-dev \
    libhdf5-fortran-102 libnetcdff-dev \
    proj-bin libproj-dev \
    vim tree git curl \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN echo "------ Installing fortran-proj ------" &&\
    cd /tmp &&\
    git clone https://gitlab.com/likeno/fortran-proj.git &&\
    cd fortran-proj &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make &&\
    make install 

# -- Installing: /usr/local/lib/libfproj.so
# -- Installing: /usr/local/include/fproj.mod

# RUN echo "------ Installing Base1 ------" &&\
#     cd $SOURCE_DIR/Mohid/Solutions/mohid-in-linux/src/Mohid_Base_1

# WORKDIR /source/Mohid/Solutions/mohid-in-linux/src/Mohid_Base_1


# # ######################
# # ### Install wgrib2 ###
# # ######################

# # RUN echo "------ Installing wgrib2 ------" \
# # &&  mkdir /tmp/wgrib2 \
# # &&  cd /tmp/wgrib2 \
# # &&  curl ftp://ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz -o wgrib2.tgz \
# # &&  tar -zxf wgrib2.tgz \
# # &&  cd grib2 \
# # &&  export CC=gcc && export FC=gfortran && make \
# # &&  cp wgrib2/wgrib2 /usr/local/bin \
# # &&  cd /tmp && rm -r /tmp/wgrib2


# # #####################################
# # ### Install ecgribs without conda ###
# # #####################################

# # # install wgrib first
# # RUN echo "------ Installing wgrib ------" \
# # &&  mkdir /tmp/wgrib \
# # &&  cd /tmp/wgrib \
# # &&  curl ftp://ftp.cpc.ncep.noaa.gov/wd51we/wgrib/wgrib.tar -o wgrib.tar \
# # &&  tar -xf wgrib.tar \
# # &&  make \
# # &&  cp wgrib /usr/local/bin \
# # &&  cd /tmp && rm -r /tmp/wgrib

# # ARG GIT_TOKEN=f65e3c9cb3e5b0afda1669ef8ca4f15858a0d816
# # ARG GIT_LFS_SKIP_SMUDGE=1

# # RUN echo '---- Install ecgribs ----' \
# # &&  cd $SOURCE_DIR \
# # &&  git clone https://$GIT_TOKEN@github.com/MetServiceDev/ecgribs.git \
# # &&  cd ecgribs \
# # &&  git fetch --tags \
# # &&  latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) \
# # &&  git checkout -b $latestTag $latestTag \
# # &&  pip3 install -r requirements.txt \
# # &&  pip3 install -e .


# # # ###############################
# # # ### Install hysplit_wrapper ###
# # # ###############################

# # ADD . $SOURCE_DIR/hysplit_wrapper
# # RUN echo '---- Install hysplit_wrapper ----' \
# # &&  cd $SOURCE_DIR/hysplit_wrapper \
# # &&  pip3 install -r requirements.txt \
# # &&  pip3 install cartopy \
# # &&  pip3 install -e .
# # # there's an issue when installing cartopy=0.18.0 and numpy at the same time
# # # https://github.com/SciTools/cartopy/issues/1552


# # # ###########################
# # # ### Install source code ###
# # # ###########################

# # ADD hysplit.v5.0.1_gfortran_rmass16.tar.gz $SOURCE_DIR/gfortran_rmass16
# # ADD hysplit.v5.0.1_gfortran.tar.gz $SOURCE_DIR/gfortran
# # ADD hysplit.v5.0.1_intel.tar.gz $SOURCE_DIR/intel

# # ENV \
# #     # need this so that $UID has write permissions
# #     MPLCONFIGDIR='/tmp/matplotlib' \
# #     CARTOPY_DATA_DIR='/tmp/cartopy' \
# #     # this doesn't have to be here because
# #     # it's also defined in hysplit_wrapper/globals.py
# #     HYSPLIT_DIR=$SOURCE_DIR/gfortran_rmass16/hysplit.v5.0.1 \
# #     # easier to be /tmp because of user permissions
# #     SCRATCH_DIR=/tmp/hysplit \
# #     REGION='us-east-2' \
# #     STATUS='research'

# # ENV PATH="${PATH}:${HYSPLIT_DIR}/exec"
# # WORKDIR $SOURCE_DIR/hysplit_wrapper


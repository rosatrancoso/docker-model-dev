FROM ubuntu:20.10
LABEL maintainer="rosatrancoso@gmail.com"

#ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y \
    make wget \
    g++ gfortran

RUN apt-get install -y \
    # ZLIB library
    zlib1g-dev \
    # SZIP library
    libsz2
    # # HDF5 all of it
    # libhdf5-dev \
    # libnetcdff-dev


ENV FCFLAGS="-w -fallow-argument-mismatch -O2" FFLAGS="-w -fallow-argument-mismatch -O2"

ADD libs /tmp/libs

# --with-szlib=DIR        Use szlib library for external szlib I/O filter
#                           [default=no]


RUN echo "Installing hdf5..." &&\
    cd /tmp/libs &&\
    #wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.22/src/hdf5-1.8.22.tar.gz &&\
    tar -zxf hdf5-1.8.22.tar.gz &&\
    cd hdf5-1.8.22 &&\
    ./configure --prefix=/usr/local --enable-fortran --enable-fortran2003 --enable-cxx --enable-hl 2>&1 | tee configure.log &&\
    make 2>&1 | tee make.log &&\
    #make check 2>&1 | tee make_check.log &&\
    make install 2>&1 | tee make_install.log

RUN h5fc -show

RUN apt-get install -y libproj-dev

RUN apt-get install -y m4

RUN echo "Installing netcdf-c..." &&\
    cd /tmp/libs &&\
    tar -zxf netcdf-c-4.8.0.tar.gz &&\
    cd netcdf-c-4.8.0 &&\
    ./configure 2>&1 | tee configure.log &&\
    make 2>&1 | tee make.log &&\
    #make check 2>&1 | tee make_check.log &&\
    make install 2>&1 | tee make_install.log


ENV LDFLAGS="-L/usr/local/lib"  CPPFLAGS="-I/usr/local/include"

RUN echo "Installing netcdf-fortran..." &&\
    cd /tmp/libs &&\
    tar -zxf netcdf-fortran-4.5.3.tar.gz &&\
    cd netcdf-fortran-4.5.3 &&\
    ./configure 2>&1 | tee configure.log &&\
    make 2>&1 | tee make.log &&\
    #make check 2>&1 | tee make_check.log &&\
    make install 2>&1 | tee make_install.log


# cd /Documents/mygit/Mohid/ExternalLibs/Proj4
# tar -zxvf libfproj4_nix_static.tar.gz
# cp -rv libfproj4/lib/ /usr/local/lib/
# cp -rv libfproj4/include/ /usr/local/include/

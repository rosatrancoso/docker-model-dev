FROM metocean/ifort:ops-bare
MAINTAINER Rosa Trancoso <rosa@metocean.co.nz>

RUN yum -y remove mpich* hdf5* netcdf* &&\
	yum -y install man make gcc-c++ glibc-static zlib-static zlib-devel &&\
    yum clean all

RUN echo "source /opt/intel/bin/compilervars.sh intel64" >> /etc/bashrc &&\
	echo "export CC=icc" >> /etc/bashrc &&\
	echo "export CXX=icpc" >> /etc/bashrc &&\
	echo "export FC=ifort" >> /etc/bashrc &&\
	echo "export F77=ifort" >> /etc/bashrc &&\
	echo "export NETCDF4=/usr/local" >> /etc/bashrc &&\
	echo "export NETCDF3=/usr/local/netcdf3" >> /etc/bashrc

# one liner to avoid multiple layers of docker
ADD install_mpich.sh /tmp/
RUN cd /tmp &&\ 
    /bin/bash --login -c "bash /tmp/install_mpich.sh" &&\
    rm -rf /tmp/*

ADD install_libs.sh /tmp/
RUN cd /tmp &&\
    /bin/bash --login -c "bash /tmp/install_libs.sh" &&\
    rm -rf /tmp/*



mkdir /tmp/libs


#######################################
## hdf5, static, no dap, no parallel ##
#######################################


echo "Installing hdf5..."
#wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.17.tar.gz
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.17/src/hdf5-1.8.17.tar.gz
tar zxvf hdf5-1.8.17.tar.gz
cd hdf5-1.8.17

cd /tmp/libs
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.22/src/hdf5-1.8.22.tar.gz
tar -zxvf hdf5-1.8.22.tar.gz
cd hdf5-1.8.22

export FCFLAGS="-w -fallow-argument-mismatch -O2"
export FFLAGS="-w -fallow-argument-mismatch -O2"


  --with-szlib=DIR        Use szlib library for external szlib I/O filter
                          [default=no]


./configure --prefix=/usr/local --enable-fortran --enable-fortran2003 --enable-cxx --enable-hl 2>&1 | tee configure.log
make 2>&1 | tee make.log
#make check 2>&1 | tee make_check.log
make install 2>&1 | tee make_install.log
cd ../

##########################################
## netcdf4, static, no dap, no parallel ##
##########################################

echo "Installing netcdf4..."
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.1.3.tar.gz
tar zxvf netcdf-4.1.3.tar.gz
cd netcdf-4.1.3
./configure --disable-dap --disable-shared --enable-static --disable-v2 2>&1 | tee configure.log
make 2>&1 | tee make.log
#make check 2>&1 | tee make_check.log
make install 2>&1 | tee make_install.log
#nc-config --all 2>&1 | tee nc-config.log
cd ../

##########################################
## netcdf3, static, no dap, no parallel ##
##########################################

echo "Installing netcdf3..."
cp -rpv netcdf-4.1.3 netcdf-4.1.3_nc3
cd netcdf-4.1.3_nc3
make distclean
./configure --prefix=/usr/local/netcdf3 --disable-dap --disable-shared --enable-static --disable-netcdf-4 2>&1 | tee configure.log
make 2>&1 | tee make.log
#make check 2>&1 | tee make_check.log
make install 2>&1 | tee make_install.log
#nc-config --all 2>&1 | tee nc-config.log
cd ../

echo "Finished $0."

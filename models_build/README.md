cd /source/docker-model-dev/models_build

# test lib hdf5

h5fc -show
gfortran \
-I/usr/include/hdf5/serial \
-L/usr/lib/x86_64-linux-gnu/hdf5/serial \
/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5hl_fortran.a \
/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_hl.a \
/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_fortran.a \
/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.a \
-lpthread -lsz -lz -ldl -lm -Wl,-rpath \
-Wl,/usr/lib/x86_64-linux-gnu/hdf5/serial \
test_hdf5.f90 -o test_hdf5_static.exe

rm test_hdf5.exe test_hdf5.hdf5
gfortran -g -fallow-argument-mismatch \
test_hdf5.f90 -o test_hdf5.exe \
-I/usr/include/hdf5/serial \
-L/usr/lib/x86_64-linux-gnu/hdf5/serial \
-lhdf5hl_fortran -lhdf5_hl -lhdf5_fortran -lhdf5 \
-lpthread -lsz -lz -ldl -lm






cd /source/Mohid/Solutions/mohid-in-linux/src/Mohid_Base_1/src
rm -rf *.o
h5fc -c ModuleGlobalData.F90
h5fc -c ModuleHDF5.F90
h5fc -c ModuleFunctions.F90
h5fc -c ModuleTime.F90
h5fc -c ModuleFunctions.F90
h5fc -c ModuleEnterData.F90
h5fc -c ModuleFunctions.F90
h5fc -c ModuleStopWatch.F90
h5fc -c ModuleFunctions.F90
h5fc -c ModuleHDF5.F90


cd /Documents/mygit/Mohid/ExternalLibs/Proj4
tar -zxvf libfproj4_nix_static.tar.gz
cp -rv libfproj4/lib/ /usr/loca/lib/
cp -rv libfproj4/include/ /usr/loca/include/

gfortran -c proj4.F90 -lproj4 -I/usr/local/include/ -L/usr/local/lib
h5fc -c ModuleFunctions.F90 -D_USE_PROJ4














nc-config --all


# Introduction

`models_build` is a docker image with `mpich`, `hdf5` and `netcdf` libraries compiled with icc and ifort, statically.
It's intended to compile models.

See https://hub.docker.com/r/metocean/models_build/

# Create image

    docker build -t metocean/models_build . 2>&1 | tee build.log

# Run docker
```
    docker run -ti --rm -u metocean -v $HERE:/home/metocean/temp -u metocean metocean/models_build

```
## Test libs

### Test ifort:

```
    cd /home/metocean/temp
    ifort -o test_dyn.exe test.f90
    ifort -Bstatic -o test_static.exe test.f90
    ldd test_dyn.exe
    ldd test_static.exe
```

### Test libs:

```
    cd /home/metocean/libs-
    nc-config --flibs  # tool to see needed libs
    ifort -o test_libs.exe test_libs.f90  $(nc-config --flibs) -lhdf5_fortran -Bstatic
    ./test_libs.exe
    ldd test_libs.exe

```

### Test mpi:

```
    mpicc -compile_info
    mpif90 -compile_info

    mpicc -o hello_world_c.exe hello_world.c
    mpif90 -o hello_world_f90.exe hello_world.f90
    
    mpd &
    mpiexec -n 2 ./hello_world_c.exe
    mpiexec -n 2 ./hello_world_f90.exe
    mpdallexit



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



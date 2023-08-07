# following the scipy-notebook dockerfile
# https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile

FROM jupyter/scipy-notebook:python-3.11

ENV PROJ_LIB=/opt/conda/share/proj

RUN mamba install -c conda-forge -y \
    boto3 \
    cartopy \
    folium \
    geopandas \
    ipyleaflet \
    netcdf4 \
    nco \
    rasterio \
    xarray \
    whitebox 

# WHydro Forcing
RUN mamba install -c conda-forge -y \
    hvplot \
    geoviews \
    esmpy
#install_requires=['netCDF4', 'numpy', 'ESMPy', 'mpi4py']

ENV ESMFMKFILE=/opt/conda/lib/esmf.mk

# ------------------------
# WhiteBox fix for NB_UID
# ------------------------
# WRF Hydro tools for routing; WhiteBox downloads data to here when it's called for the first time
RUN SITE_PACKAGES=`python -c 'import site; print(site.getsitepackages()[0])'` &&\
    echo $SITE_PACKAGES &&\
    chmod -R a+w $SITE_PACKAGES/whitebox/


# things to compile WRF-HYDRO need root user

# When compiling WRF do:
#   conda deactivate
#   export LD_LIBRARY_PATH=$NETCDF_LIB
#   export LIBRARY_PATH=$NETCDF_LIB
# https://stackoverflow.com/questions/558803/how-can-i-add-a-default-include-path-for-gcc-in-linux
#   export PATH2=$PATH
#   export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN apt -y update
RUN apt install -y \
    vim \
    libmpich-dev \
    libnetcdff-dev \
    netcdf-bin \
    make

ENV NETCDF_INC=/usr/include
ENV NETCDF_LIB=/usr/lib/x86_64-linux-gnu/

ADD jupyter_functions.py /source/jupyter_functions.py


#https://github.com/NCAR/WrfHydroForcing/archive/refs/tags/v3.0-beta4.zip


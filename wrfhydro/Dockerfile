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


# ------------------------
# WhiteBox fix for NB_UID
# ------------------------
# WRF Hydro tools for routing; WhiteBox downloads data to here when it's called for the first time
RUN SITE_PACKAGES=`python -c 'import site; print(site.getsitepackages()[0])'` &&\
    echo $SITE_PACKAGES &&\
    chmod -R a+w $SITE_PACKAGES/whitebox/


# things to compile WRF-HYDRO

ARG DEBIAN_FRONTEND=noninteractive
RUN apt -y update &&\
    apt install -y \
    vim \
    libmpich-dev \
    libnetcdff-dev \
    netcdf-bin \
    make

ENV NETCDF_INC=/usr/include
ENV NETCDF_LIB=/usr/lib/x86_64-linux-gnu/



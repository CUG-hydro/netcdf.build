#!/bin/sh
#
# install_netcdf.sh
# Copyright (C) 2018 Daniel Santiago <dpelaez@cicese.edu.mx>
#
# Distributed under terms of the GNU/GPL license.
#
set -e

# ============================================================================
#  Installation of NetCDF4 Fortran libraries
# ----------------------------------------------------------------------------
#
#  Purpose:
#    This script get the given versions of the NetCD4 libreries and its
#    dependencies and install them in the MAINDIR=/usr/local/netcdf/ directory
#
#  Usage:
#    [sudo] CC=gcc FC=gfortran MAINDIR=/usr/local/netcdf ./install_netcdf.sh
#
#  Autor:
#    Daniel Santiago, github/dspelaez
#    Dongdong Kong, 2024-02-16
#
# ============================================================================

# version of libs
CLTAG=${CLTAG:-"8.6.0"}
ZLTAG=${ZLTAG:-"1.3"}
H5TAG=${H5TAG:-"1.14.0"}
PNCTAG=${PNCTAG:-"1.12.3"}
NCTAG=${NCTAG:-"4.9.2"}
NFTAG=${NFTAG:-"4.6.1"}

## define compilers
CXX=${CXX:-mpicxx}
CC=${CC:-mpicc}
FC=${FC:-mpifort}
F90=${FC}
F77=${FC}

# main directory
# MAINDIR=${MAINDIR:-${HOME}/environment}
MAINDIR=/opt/netcdf_v4.9.2_openmpi

NCDIR=$MAINDIR
PNDIR=$NCDIR # pnetcdf与netcdf安装在相同文件夹
CLDIR=$NCDIR/zlib
ZDIR=$NCDIR/zlib
H5DIR=$NCDIR/hdf5

echo "netcdf-c: $NCTAG"
echo $NCDIR

## donwload source code of depencies
download() {
  args=-nv

  wget $args https://curl.haxx.se/download/curl-$CLTAG.tar.gz
  wget $args https://zlib.net/fossils/zlib-$ZLTAG.tar.gz
  # wget $args https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$(echo $H5TAG | cut -d. -f 1,2)/hdf5-$H5TAG/src/hdf5-$H5TAG.tar.gz
  wget $args https://downloads.unidata.ucar.edu/netcdf-c/$NCTAG/netcdf-c-$NCTAG.tar.gz
  wget $args https://downloads.unidata.ucar.edu/netcdf-fortran/$NFTAG/netcdf-fortran-$NFTAG.tar.gz
  wget $args https://parallel-netcdf.github.io/Release/pnetcdf-$PNCTAG.tar.gz
  # cd ..
}

build_curl() {
  tar -xf curl-$CLTAG.tar.gz
  cd curl-$CLTAG/

  # sudo apt install libpsl-dev
  ./configure --prefix=${CLDIR} --with-openssl
  make -j8
  make install
  cd ..
}

build_zlib() {
  tar -xf zlib-$ZLTAG.tar.gz
  cd zlib-$ZLTAG/

  ./configure --prefix=${ZDIR}
  make -j8
  make install
  cd ..
}

build_pnetcdf() {
  # wget https://parallel-netcdf.github.io/Release/pnetcdf-$PNCTAG.tar.gz
  tar -xf pnetcdf-$PNCTAG.tar.gz
  cd pnetcdf-$PNCTAG
  ls -l
  ./configure --prefix=${PNDIR} --enable-shared --disable-cxx
  make -j8
  make install
  cd ..
}

build_hdf5() {
  wget -nv https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$(echo $H5TAG | cut -d. -f 1,2)/hdf5-$H5TAG/src/hdf5-$H5TAG.tar.gz

  tar -xf hdf5-$H5TAG.tar.gz
  cd hdf5-$H5TAG/
  ./configure --with-zlib=${ZDIR} --prefix=${H5DIR} --enable-parallel
  make -j8
  # make check
  make install
  cd ..
}

build_netcdf() {
  tar -xf netcdf-c-$NCTAG.tar.gz
  cd netcdf-c-$NCTAG/
  CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=${NCDIR} \
    --disable-libxml2 --enable-parallel-tests
  make -j8
  # make check
  make install
  cd ..
}

build_netcdff() {
  tar -xf netcdf-fortran-$NFTAG.tar.gz
  cd netcdf-fortran-$NFTAG/
  CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NCDIR}
  make -j8
  # make check
  make install
  cd ..
}

mkdir -p pkgs
cd pkgs

# build_curl
# build_zlib
# build_pnetcdf
# build_hdf5
# build_netcdf
# build_netcdff

## show compilation options
# $NCDIR/bin/nf-config --all
# export LD_LIBRARY_PATH="$NCDIR/lib:$LD_LIBRARY_PATH"

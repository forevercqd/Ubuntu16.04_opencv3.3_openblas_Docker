#!/usr/bin/bash

# Build OpenBLAS and clean up build dependencies to have put everything in a
# single RUN step and workaround for:
# https://github.com/docker/docker/issues/332

set -xe
BUILD_DIR=/opt/openblas_build
cd $BUILD_DIR

apt-get -y update
apt-get -y install build-essential gfortran

# Build latest stable release from OpenBLAS from source
unzip OpenBLAS-0.2.18.zip
(cd OpenBLAS-0.2.18 \
    && make  DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 \
    && make PREFIX=/usr/local/OpenBLAS install)

# Rebuild ld cache, this assumes that:
# /etc/ld.so.conf.d/openblas.conf was installed by Dockerfile
# and that the libraries are in /opt/OpenBLAS/lib
ldconfig

cd /
rm -rf $BUILD_DIR
rm -rf /build_openblas.sh

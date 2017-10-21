#!/bin/bash

set -xe
BUILD_DIR=/opt/opencv_build/

cd $BUILD_DIR

unzip opencv-3.3.0.zip
ls -al
cd opencv-3.3.0
ls -al
mkdir build
cd build
apt-get clean
apt-get update
apt-get install -y  build-essential
apt-get install -y  cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
apt-get install -y  python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j4
make install


cd $BUILD_DIR
rm opencv-3.3.0.zip
rm -rf opencv-3.3.0

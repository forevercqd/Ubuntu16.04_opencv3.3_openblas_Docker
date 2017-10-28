#!/bin/bash
ROOT_DIR=`pwd`
OPEN_BLAS_DIR=/usr/local/OpenBLAS

export LD_LIBRARY_PATH=$ROOT_DIR/lib:${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH}
export LD_PRELOAD="$ROOT_DIR/lib/libwebp/libwebp.so $ROOT_DIR/lib/libwebp/libwebpdemux.so $ROOT_DIR/lib/libwebp/libwebpmux.so $ROOT_DIR/lib/libdeeplab.so $ROOT_DIR/lib/libdeeplab_data.so /usr/local/lib/libopencv_imgcodecs.so $OPEN_BLAS_DIR/lib/libopenblas.so"

echo cqd,  $LD_LIBRARY_PATH
echo cqd,  $LD_PRELOAD

javac -cp .:./objectdetection_lib.jar ObjectDetectionTest.java
java -cp .:./objectdetection_lib.jar ObjectDetectionTest

FROM nvidia/cuda:8.0-cudnn7-devel-ubuntu16.04
# base lib	
RUN apt-get update && apt-get install -y --no-install-recommends \
    subversion  \
    zip \
    git \
    wget \
    curl \
    vim \
    zsh \
    unzip

######################################################
# Install Java.
ADD	build_java.sh	build_java.sh
RUN /bin/bash build_java.sh
 
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/local/java/jdk1.8.0
ENV PATH $JAVA_HOME/bin:$PATH
 
######################################################

######################################################
# OpenCV
# Run OpenCV build script
ADD opencv-3.3.0.zip /opt/opencv_build/
ADD build_opencv-3.3.0.sh build_opencv-3.3.0.sh
RUN bash build_opencv-3.3.0.sh
RUN ldconfig
######################################################


######################################################
# OpenBLAS v0.2.18
ADD OpenBLAS-0.2.18.zip /opt/openblas_build/OpenBLAS-0.2.18.zip
ADD openblas.conf /etc/ld.so.conf.d/openblas.conf
ADD build_openblas.sh build_openblas.sh
RUN bash build_openblas.sh
######################################################

RUN rm -rf /var/lib/apt/lists/*

######################################################
# install the caffe envirment
ADD build_caffe_env.sh build_caffe_env.sh
RUN /bin/bash build_caffe_env.sh
######################################################

# ADD so file
ADD lib/ /usr/local/matting/lib/
ADD java/ /data/java/
#ADD libwebp_ubuntu_x64/ /data/libwebp_ubuntu_x64/
ENV LD_LIBRARY_PATH /usr/local/matting/lib:$LD_LIBRARY_PATH
#ENV LD_PRELOAD="/usr/local/matting/lib/libwebp.so /usr/local/matting/lib/libwebpdemux.so /usr/local/matting/lib/libwebpmux.so /usr/local/matting/lib/libfcn.so /usr/local/lib/libopencv_imgcodecs.so /opt/OpenBLAS/lib/libopenblas.so"
	
WORKDIR /data
# Define default command.
CMD ["zsh"]

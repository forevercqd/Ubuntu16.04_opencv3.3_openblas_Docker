FROM nvidia/cuda:8.0-cudnn7-devel-ubuntu16.04
# base lib	
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    cmake \
    g++ \
    git \
    wget \
    curl \
    vim \
    zsh \
    unzip \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python-dev \
    python-numpy \
    python-pip \
    python-setuptools \
    python-scipy \
    libavformat-dev \
    libavcodec-dev libavfilter-dev libswscale-dev \
    libjpeg-dev libpng-dev libtiff-dev libjasper-dev zlib1g-dev libopenexr-dev libxine2-dev libeigen3-dev libtbb-dev

######################################################
# Install Java.
RUN \
    apt-get install -y software-properties-common && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
######################################################

######################################################
# CAFFE

#ENV CAFFE_ROOT=/opt/caffe
#WORKDIR $CAFFE_ROOT
#
## FIXME: use ARG instead of ENV once DockerHub supports this
## https://github.com/docker/hub-feedback/issues/460
#ENV CLONE_TAG=1.0
#
#RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
#    pip install --upgrade pip && \
#    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
#    mkdir build && cd build && \
#    cmake -DCPU_ONLY=1 .. && \
#    make -j"$(nproc)"
#
#ENV PYCAFFE_ROOT $CAFFE_ROOT/python
#ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
#ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
#RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
######################################################

######################################################
# OpenCV 3.1.0

# Define working directory.
ADD opencv-3.3.0.zip /opt/opencv_build/
ADD build_opencv-3.3.0.sh build_opencv-3.3.0.sh
RUN bash build_opencv-3.3.0.sh


#ADD  opencv-3.3.0.zip ~/
#RUN \
#    cd ~/   \
#    && ls -al   \
#    && unzip opencv-3.3.0.zip \
#    && ls -al   \
#    && cd ~/opencv-3.3.0\
#    && ls -al   \
#    && mkdir build \
#    && cd build \
#    && apt-get install build-essential  \
#    && apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
#    && apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
#    && cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. \
#    && make -j4 \
#    && make install \
#    && cd \
#    && rm 3.1.0.zip \
#    && rm -rf opencv-3.3.0


# OpenBLAS v0.2.18
ADD openblas.conf /etc/ld.so.conf.d/openblas.conf
ADD build_openblas.sh build_openblas.sh
RUN bash build_openblas.sh
######################################################

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /data
# Define default command.
CMD ["bash"]

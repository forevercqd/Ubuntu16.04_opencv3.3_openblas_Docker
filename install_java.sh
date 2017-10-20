#!/bin/bash

set -xe
BUILD_DIR=/usr/local
cd $BUILD_DIR
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
tar -zxvf jdk-8u151-linux-x64.tar.gz 
mv jdk1.8.0_151  java
rm jdk-8u151-linux-x64.tar.gz



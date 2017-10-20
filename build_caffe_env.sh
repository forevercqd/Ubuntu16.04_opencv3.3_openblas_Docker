#!/bin/bash

apt-get update                                                                                      
apt-get upgrade                                                                                     
apt-get install -y build-essential cmake git pkg-config                                             
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
apt-get install -y libatlas-base-dev                                                                
apt-get install -y --no-install-recommends libboost-all-dev                                         
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev                                     
apt-get install -y python-pip                                                                       
apt-get install -y python-dev                                                                       
apt-get install -y python-numpy python-scipy                                                        
apt-get install -y libopencv-dev 

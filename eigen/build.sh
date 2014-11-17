#!/bin/bash
mkdir build
cd build

cmake ..  \
-DEIGEN_INCLUDE_INSTALL_DIR=$INCLUDE_PATH \
-DCMAKE_BUILD_TYPE=Release \
-Dpkg_config_libdir=$LIBRARY_PATH

make
make install


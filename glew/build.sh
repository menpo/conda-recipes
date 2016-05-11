#!/bin/bash

CFLAGS="-I/Users/pts08/gits/mesa/test/include"
LDFLAGS="-L/Users/pts08/gits/mesa/test/lib"

cd build

mkdir build_glew
cd build_glew
cmake ../cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DBUILD_UTILS=1 -DGLEW_OSMESA=1
make -j$CPU_COUNT
make install

cd ..
mkdir build_test
cd build_test
cmake ../cmake/testbuild -DCMAKE_INSTALL_PREFIX=${PWD}/out -DCMAKE_PREFIX_PATH=${PWD}/out -DCMAKE_BUILD_TYPE=Release
make -j$CPU_COUNT
make install

# Copy the libs just for testing
cp $PREFIX/lib/libGLEW.dylib .
out/bin/cmake-test

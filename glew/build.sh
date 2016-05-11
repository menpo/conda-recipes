#!/bin/bash

export CFLAGS="-I/vol/atlas/homes/pts08/gits/mesa/test/include"
export LDFLAGS="-L/vol/atlas/homes/pts08/gits/mesa/test/lib"

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
if [ "$(uname -s)" == "Darwin" ]; then
  cp $PREFIX/lib/libGLEW.dylib out/bin/
else
  cp /vol/atlas/homes/pts08/gits/mesa/test/lib/*.so* $PREFIX/lib/
  patchelf --set-rpath '$ORIGIN/./' $PREFIX/lib/libGLEW.so
  patchelf --set-rpath $PREFIX/lib out/bin/cmake-test
fi
out/bin/cmake-test

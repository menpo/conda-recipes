#!/bin/bash
mkdir build
cd build

CMAKE_GENERATOR="Unix Makefiles"
CMAKE_ARCH="-m"$ARCH

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  export CFLAGS="$CFLAGS $CMAKE_ARCH"
  export LDLAGS="$LDLAGS $CMAKE_ARCH"
fi

cmake .. -G"$CMAKE_GENERATOR" \
-DBUILD_SHARED_LIBS=1 \
-DCMAKE_INSTALL_PREFIX=$PREFIX

make
make install

rm -rf $PREFIX/lib/cmake
rm -rf $PREFIX/lib/pkgconfig

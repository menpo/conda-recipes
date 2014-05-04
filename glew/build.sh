#!/bin/bash
mkdir build
cd build
ARCH=64
PY_VER=2
if [ $ARCH -eq 64 ]; then
  echo 64 bit
  if [ $PY_VER -lt 3 ]; then 
    CMAKE_GENERATOR="Unix Makefiles"
    CMAKE_ARCH="-m64"
    echo Using Python 2
  fi
fi

cmake .. -G"$CMAKE_GENERATOR" \
-DBUILD_SHARED_LIBS=1 \
-DCMAKE_INSTALL_PREFIX=$PREFIX \

make
make install

rm -rf $PREFIX/lib/cmake
rm -rf $PREFIX/lib/pkgconfig


#!/bin/bash
mkdir build
cd build

if [ $ARCH -eq 64 ]; then
  if [ "$PY_VER" == "2.7" ]; then 
    CMAKE_GENERATOR="Unix Makefiles"
    CMAKE_ARCH="-m64"
  fi
fi

cmake .. -G"$CMAKE_GENERATOR" \
-DENABLE_BOOST_WORKAROUND=1 \
-DBUILD_ASSIMP_TOOLS=0 \
-DCMAKE_INSTALL_PREFIX=$PREFIX

make
make install

rm -rf $PREFIX/lib/cmake
rm -rf $PREFIX/lib/pkgconfig


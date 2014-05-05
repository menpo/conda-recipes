#!/bin/bash
mkdir build
cd build

if [ $ARCH -eq 64 ]; then
  if [ "$PY_VER" == "2.7" ]; then 
    CMAKE_GENERATOR="Unix Makefiles"
    CMAKE_ARCH="-m64"
  fi
fi

# On OSX we need to use boost, so make sure
# that you 'brew install boost' before running
# this script
if [ "$(uname)" == "Darwin" ]; then
  BOOST_WORKAROUND=0
  CMAKE_ARCH=""
else
  BOOST_WORKAROUND=1
fi


cmake .. -G"$CMAKE_GENERATOR" \
-DENABLE_BOOST_WORKAROUND=$BOOST_WORKAROUND \
-DBUILD_ASSIMP_TOOLS=0 \
-DCMAKE_INSTALL_PREFIX=$PREFIX

make
make install

rm -rf $PREFIX/lib/cmake
rm -rf $PREFIX/lib/pkgconfig


#!/bin/bash
mkdir build
cd build

CMAKE_GENERATOR="Unix Makefiles"
CMAKE_ARCH="-m"$ARCH

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  export CFLAGS="$CFLAGS -fPIC $CMAKE_ARCH"
  export LDLAGS="$LDLAGS $CMAKE_ARCH"
  DYNAMIC_EXT="so"
fi
if [ "$(uname -s)" == "Darwin" ]; then
  DYNAMIC_EXT="dylib"
fi

export LDFLAGS="-L$PREFIX/lib $LDFLAGS"

cmake ../tools/python -G"$CMAKE_GENERATOR" \
-DBUILD_SHARED_LIBS=1 \
-DBoost_USE_STATIC_LIBS=0 \
-DBoost_USE_STATIC_RUNTIME=0 \
-DBOOST_INCLUDEDIR=$PREFIX/include \
-DBOOST_LIBRARYDIR=$PREFIX/lib \
-DPYTHON_LIBRARY=$PREFIX/lib/libpython$PY_VER.$DYNAMIC_EXT \
-DPYTHON_INCLUDE=$PREFIX/lib/python$PY_VER

cmake --build . --config Release --target install

cp dlib.$DYNAMIC_EXT $SP_DIR


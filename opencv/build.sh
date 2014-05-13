#!/bin/bash
mkdir build
cd build

CMAKE_GENERATOR="Unix Makefiles"
CMAKE_ARCH="-m"$ARCH

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  export CFLAGS="$CFLAGS $CMAKE_ARCH"
  export LDLAGS="$LDLAGS $CMAKE_ARCH"
  DYNAMIC_EXT="so"
fi
if [ "$(uname -s)" == "Darwin" ]; then
  DYNAMIC_EXT="dylib"
fi

export CFLAGS="-I$PREFIX/include -fPIC $CFLAGS" 
export LDFLAGS="-L$PREFIX/lib $LDFLAGS"

cmake .. -G"$CMAKE_GENERATOR"                                            \
    -DBUILD_TESTS=0                                                      \
    -DBUILD_DOCS=0                                                       \
    -DBUILD_PERF_TESTS=0                                                 \
    -DBUILD_ZLIB=0                                                       \
    -DBUILD_TIFF=1                                                       \
    -DBUILD_PNG=0                                                        \
    -DBUILD_OPENEXR=0                                                    \
    -DBUILD_JASPER=0                                                     \
    -DBUILD_JPEG=0                                                       \
    -DJPEG_INCLUDE_DIR=$PREFIX/include                                   \
    -DJPEG_LIBRARY=$PREFIX/lib/libjpeg.$DYNAMIC_EXT                      \
    -DPNG_PNG_INCLUDE_DIR=$PREFIX/include                                \
    -DPNG_LIBRARY=$PREFIX/lib/libpng.$DYNAMIC_EXT                        \
    -DZLIB_INCLUDE_DIR=$PREFIX/include                                   \
    -DZLIB_LIBRARY=$PREFIX/lib/libz.$DYNAMIC_EXT                         \
    -DPYTHON_EXECUTABLE=$PREFIX/bin/python${PY_VER}                      \
    -DPYTHON_INCLUDE_PATH=$PREFIX/include/python${PY_VER}                \
    -DPYTHON_LIBRARY=$PREFIX/lib/libpython${PY_VER}.$DYNAMIC_EXT         \
    -DPYTHON_PACKAGES_PATH=$SP_DIR                                       \
    -DWITH_CUDA=0                                                        \
    -DWITH_OPENCL=0                                                      \
    -DWITH_OPENNI=0                                                      \
    -DWITH_FFMPEG=0                                                      \
    -DWITH_TBB=1                                                         \
    -DCMAKE_INSTALL_PREFIX=$PREFIX
make
make install

rm -rf $PREFIX/share/OpenCV
rm -rf $PREFIX/lib/cmake
rm -rf $PREFIX/lib/pkgconfig


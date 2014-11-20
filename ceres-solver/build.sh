#!/bin/bash
mkdir build
cd build

if [ "$(uname -s)" == "Darwin" ]; then
  export MACOSX_DEPLOYMENT_TARGET=10.6
  EXTRA_CXX_FLAGS=""
  DYNAMIC_EXT="dylib"
fi
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # The wno-error is for Linux, GCC complains about unused typedefs Scalar from Eigen
  EXTRA_CXX_FLAGS="-Wno-unused-local-typedefs -Wno-maybe-uninitialized"
  DYNAMIC_EXT="so"
fi

# Start with static

function CMAKE_OPTIONS {
    OPT="-DBUILD_TESTING=0 -DMINIGLOG=1 -DEIGEN_INCLUDE_DIR=$INCLUDE_PATH -DMETIS_LIBRARY=$LIBRARY_PATH/libmetis.$1 -DAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DAMD_LIBRARY=$LIBRARY_PATH/libamd.$1  -DCAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DCAMD_LIBRARY=$LIBRARY_PATH/libcamd.$1  -DCOLAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DCOLAMD_LIBRARY=$LIBRARY_PATH/libcolamd.$1 -DCCOLAMD_LIBRARY=$LIBRARY_PATH/libccolamd.$1 -DCCOLAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DCHOLMOD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DCHOLMOD_LIBRARY=$LIBRARY_PATH/libcholmod.$1 -DCXSPARSE_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DCXSPARSE_LIBRARY=$LIBRARY_PATH/libcxsparse.$1 -DSUITESPARSEQR_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DSUITESPARSEQR_LIBRARY=$LIBRARY_PATH/libspqr.$1 -DSUITESPARSE_CONFIG_INCLUDE_DIR=$INCLUDE_PATH/suitesparse -DSUITESPARSE_CONFIG_LIBRARY=$LIBRARY_PATH/libsuitesparseconfig.$1 -DTBB_MALLOC_LIB=$LIBRARY_PATH/libtbbmalloc.$DYNAMIC_EXT -DTBB_LIBRARIES=$LIBRARY_PATH/libtbb.$DYNAMIC_EXT -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
}

CMAKE_OPTIONS a

cmake .. $OPT -DCMAKE_CXX_FLAGS="$EXTRA_CXX_FLAGS"

make -j$CPU_COUNT
make install

# I know this should be DYNAMIC_EXT, but I cannot get the suitesparse shared libraries to link correctly?
CMAKE_OPTIONS a

cmake .. $OPT -DBUILD_SHARED_LIBS=1 -DCMAKE_CXX_FLAGS="$EXTRA_CXX_FLAGS" -DCMAKE_POSITION_INDEPENDENT_CODE=1

make -j$CPU_COUNT
make install

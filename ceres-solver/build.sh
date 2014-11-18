#!/bin/bash
mkdir build
cd build

if [ "$(uname -s)" == "Darwin" ]; then
  export MACOSX_DEPLOYMENT_TARGET=10.6
fi
# The wno-error is for Linux, GCC complains about unused typedefs Scalar from Eigen
cmake .. \
-DCMAKE_CXX_FLAGS="-Wno-error=unused-local-typedefs" \
-DMINIGLOG=1 \
-DEIGEN_INCLUDE_DIR=$INCLUDE_PATH \
-DMETIS_LIBRARY=$LIBRARY_PATH/libmetis.a \
-DAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DAMD_LIBRARY=$LIBRARY_PATH/libamd.a  \
-DCAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DCAMD_LIBRARY=$LIBRARY_PATH/libcamd.a  \
-DCOLAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DCOLAMD_LIBRARY=$LIBRARY_PATH/libcolamd.a \
-DCCOLAMD_LIBRARY=$LIBRARY_PATH/libccolamd.a \
-DCCOLAMD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DCHOLMOD_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DCHOLMOD_LIBRARY=$LIBRARY_PATH/libcholmod.a \
-DCXSPARSE_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DCXSPARSE_LIBRARY=$LIBRARY_PATH/libcxsparse.a \
-DSUITESPARSEQR_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DSUITESPARSEQR_LIBRARY=$LIBRARY_PATH/libspqr.a \
-DSUITESPARSE_CONFIG_INCLUDE_DIR=$INCLUDE_PATH/suitesparse \
-DSUITESPARSE_CONFIG_LIBRARY=$LIBRARY_PATH/libsuitesparseconfig.a \
-DTBB_MALLOC_LIB=$LIBRARY_PATH/libtbbmalloc.dylib \
-DTBB_LIBRARIES=$LIBRARY_PATH/libtbb.dylib \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DCMAKE_BUILD_TYPE=Release

make -j$CPU_COUNT
make install


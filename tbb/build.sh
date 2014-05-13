#!/bin/bash

MAKE_ARCH="-m"$ARCH

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  export CFLAGS="$CFLAGS $MAKE_ARCH"
  export LDLAGS="$LDLAGS $MAKE_ARCH"
  DYNAMIC_EXT=s
  COMPILER=g++
fi
if [ "$(uname -s)" == "Darwin" ]; then
  DYNAMIC_EXT=dylib
  COMPILER=clang
fi

make tbb_build_prefix= compiler=$COMPILER

mkdir $PREFIX/lib
mkdir $PREFIX/include
cp -R build/_release/*.$DYNAMIC_EXT $PREFIX/lib/
cp -R include/ $PREFIX/include/

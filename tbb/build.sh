#!/usr/bin/env bash

mkdir -p "$INCLUDE_PATH/tbb" && cp -R "include/tbb/" "$INCLUDE_PATH/tbb"
mkdir -p "$INCLUDE_PATH/serial" && cp -R "include/serial/" "$INCLUDE_PATH/serial"

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  DYNAMIC_EXT="so"
fi
if [ "$(uname -s)" == "Darwin" ]; then
  DYNAMIC_EXT="dylib"
fi

rsync -aPq lib/*.${DYNAMIC_EXT} ${LIBRARY_PATH}

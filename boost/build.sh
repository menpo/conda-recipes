#!/bin/bash

./bootstrap.sh
./bjam link=shared --with-python stage

mkdir -p $PREFIX/lib
cp -a stage/lib $PREFIX
mkdir -p $PREFIX/include
cp -R boost $PREFIX/include

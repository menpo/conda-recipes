#!/bin/bash
# This is only for Linux!

export CFLAGS="$CFLAGS -I$PREFIX/include"
export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
./configure --prefix=$PREFIX --without-gdiplus

make
make install


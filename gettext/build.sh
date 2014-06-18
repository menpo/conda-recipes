#!/bin/bash
# This is only for Linux!

./configure --prefix=$PREFIX --with-included-gettext --with-included-glib --with-included-libcroco --with-included-libunistring --disable-java --disable-csharp --without-git --without-cvs

make
make install


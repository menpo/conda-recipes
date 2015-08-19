if [ "$(uname -s)" == "Darwin" ]; then
  ./bootstrap               \
    --prefix=$PREFIX        \
    --no-qt-gui             \
    --parallel=${CPU_COUNT} \
    --no-system-libs

  make -j${CPU_COUNT}
  make install
else
  chmod 755 cmake_install.sh
  ./cmake_install.sh --prefix=$PREFIX --skip-license
fi


@echo off

mkdir build
cd build
cmake .. ^
 -DENABLE_BOOST_WORKAROUND=1 ^
 -DBUILD_ASSIMP_TOOLS=0 ^
 -DINCLUDE_INSTALL_DIR=%LIBRARY_INC% ^
 -DLIB_INSTALL_DIR=%LIBRARY_LIB% ^
 -DBIN_INSTALL_DIR=%LIBRARY_BIN%

cmake --build . --config "Release|Win"%ARCH% --target ALL_BUILD
cmake --build . --config "Release|Win"%ARCH% --target INSTALL
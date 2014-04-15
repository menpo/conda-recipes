@echo off

mkdir build
cd build
cmake .. ^
 -DBUILD_SHARED_LIBS=1 ^
 -DINCLUDE_INSTALL_DIR=%LIBRARY_INC% ^
 -DLIB_INSTALL_DIR=%LIBRARY_LIB% ^
 -DBIN_INSTALL_DIR=%LIBRARY_BIN% ^
 -DLIB_SUFFIX= ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
 -DUSE_MSVC_RUNTIME_LIBRARY_DLL=1

cmake --build . --config "Release|Win"%ARCH% --target ALL_BUILD
cmake --build . --config "Release|Win"%ARCH% --target INSTALL
@echo off

mkdir build
cd build

rem Need to handle Python 3.x case at some point (Visual Studio 2010)
if %ARCH%==32 AND %PY_VER%<3 (
  set CMAKE_GENERATOR="Visual Studio 9 2008"
  set CMAKE_CONFIG="Release|Win32"
)
if %ARCH%==64 AND %PY_VER%<3 (
  set CMAKE_GENERATOR="Visual Studio 9 2008 Win64"
  set CMAKE_CONFIG="Release|x64"
)

cmake .. -G%CMAKE_GENERATOR% ^
 -DBUILD_SHARED_LIBS=1 ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%

cmake --build . --config %CMAKE_CONFIG% --target ALL_BUILD
cmake --build . --config %CMAKE_CONFIG% --target INSTALL
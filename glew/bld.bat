@echo off

mkdir output
cd output
cmake .. -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%

cmake --build . --config "Release|Win"%ARCH% --target ALL_BUILD
cmake --build . --config "Release|Win"%ARCH% --target INSTALL
@echo off

echo "Copying stdint.h for windows"
cp "%LIBRARY_INC%\stdint.h" "modules\videoio\src\stdint.h"
cp "%LIBRARY_INC%\stdint.h" "modules\calib3d\src\stdint.h"

mkdir build
cd build

rem Need to handle Python 3.x case at some point (Visual Studio 2010)
if %ARCH%==32 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008"
    set CMAKE_CONFIG="Release|Win32"
	set OPENCV_ARCH=x86
	set OPENCV_VC=vc9
  )
)
if %ARCH%==64 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008 Win64"
    set CMAKE_CONFIG="Release|x64"
	set OPENCV_ARCH=x64
	set OPENCV_VC=vc9
  )
)

set PY_INCLUDE_PATH="%PREFIX%\include"
set PY_INCLUDE_PATH=%PY_INCLUDE_PATH:\=/%

set PY_LIBRARY="%PREFIX%\libs\python27.lib"
set PY_LIBRARY=%PY_LIBRARY:\=/%

set PY_SP_DIR="%SP_DIR%"
set PY_SP_DIR=%PY_SP_DIR:\=/%

set PY_EXEC="%PYTHON%"
set PY_EXEC=%PY_EXEC:\=/%

cmake .. -G%CMAKE_GENERATOR%                        ^
    -DWITH_EIGEN=1                                  ^
    -DBUILD_TESTS=0                                 ^
    -DBUILD_DOCS=0                                  ^
    -DBUILD_PERF_TESTS=0                            ^
    -DBUILD_ZLIB=1                                  ^
    -DBUILD_TIFF=1                                  ^
    -DBUILD_PNG=1                                   ^
    -DBUILD_OPENEXR=1                               ^
    -DBUILD_JASPER=1                                ^
    -DBUILD_JPEG=1                                  ^
    -DWITH_CUDA=0                                   ^
    -DWITH_OPENCL=0                                 ^
    -DWITH_OPENNI=0                                 ^
    -DWITH_FFMPEG=0                                 ^
    -DPYTHON2_EXECUTABLE=%PY_EXEC%                  ^
    -DPYTHON2_INCLUDE_DIR=%PY_INCLUDE_PATH%         ^
    -DPYTHON_INCLUDE_DIR2=%PY_INCLUDE_PATH%         ^
    -DPYTHON2_LIBRARY=%PY_LIBRARY%                  ^
    -DPYTHON2_PACKAGES_PATH=%PY_SP_DIR%             ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"

cmake --build . --config %CMAKE_CONFIG% --target ALL_BUILD
cmake --build . --config %CMAKE_CONFIG% --target INSTALL

rem Let's just move the files around to a more sane structure (flat)
move "%LIBRARY_PREFIX%\%OPENCV_ARCH%\%OPENCV_VC%\bin\*.dll" "%LIBRARY_LIB%"
move "%LIBRARY_PREFIX%\%OPENCV_ARCH%\%OPENCV_VC%\bin\*.exe" "%LIBRARY_BIN%"
move "%LIBRARY_PREFIX%\%OPENCV_ARCH%\%OPENCV_VC%\lib\*.lib" "%LIBRARY_LIB%"
rmdir "%LIBRARY_PREFIX%\%OPENCV_ARCH%" /S /Q

rem By default cv.py is installed directly in site-packages
rem Therefore, we have to copy all of the dlls directly into it!
xcopy "%LIBRARY_LIB%\opencv*.dll" "%SP_DIR%"

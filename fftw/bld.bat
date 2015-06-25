rem Use CMAKE to build FFTW for Windows. I wrote the CMAKE script myself so that
rem in the future generation of Visual Studio 9 and 10 won't involve maintang
rem separate solution files.

rem IMPORTANT: I had real trouble getting OpenMP to work in Visual Studio,
rem particularly for 64-bit builds because it seems the express versions of
rem Visual Studio don't ship with 64-bit compilers by default. Since I am
rem only building this project to link against it from Python, I have to build
rem against specific Python versions. Therefore, to get this to work I have
rem disabled threading. Obviously this makes FFTW slower, but at least it
rem work out of the box on Windows. I would welcome a Virtual Machine that
rem could build 32-bit and 64-bit builds of FFTW with threading enabled!

rem Copy my custom CMAKE build across.
copy "%RECIPE_DIR%\CMakelists.txt" CMakelists.txt
copy "%RECIPE_DIR%\config.h" config.h

mkdir build
cd build

rem Need to handle Python 3.x case at some point (Visual Studio 2010)
if %ARCH%==32 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008"
    set CMAKE_CONFIG="Release|Win32"
  )
)
if %ARCH%==64 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008 Win64"
    set CMAKE_CONFIG="Release|x64"
  )
)

cmake .. -G%CMAKE_GENERATOR%
cmake --build . --config %CMAKE_CONFIG% --target ALL_BUILD

rem No install target, copy manually
xcopy Release\*.lib "%LIBRARY_LIB%\"
xcopy Release\*.dll "%LIBRARY_BIN%\"
copy ..\api\fftw3.h "%LIBRARY_INC%\fftw3.h"

if errorlevel 1 exit 1

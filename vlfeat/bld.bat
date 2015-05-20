if %ARCH% EQU 32 (
  set VL_ARCH="win32"
  call "%VCINSTALLDIR%\vcvarsall.bat" x86
) else (
  set VL_ARCH="win64"
  call "%VCINSTALLDIR%\vcvarsall.bat" amd64
)

nmake /f Makefile.mak ARCH=%VL_ARCH%

copy "bin\%VL_ARCH%\sift.exe" "%LIBRARY_BIN%\sift.exe"
copy "bin\%VL_ARCH%\mser.exe" "%LIBRARY_BIN%\mser.exe"
copy "bin\%VL_ARCH%\aib.exe"  "%LIBRARY_BIN%\aib.exe"

copy "bin\%VL_ARCH%\vl.dll" "%LIBRARY_BIN%\vl.dll"
copy "bin\%VL_ARCH%\vl.exp" "%LIBRARY_BIN%\vl.exp"
copy "bin\%VL_ARCH%\vl.lib" "%LIBRARY_BIN%\vl.lib"

robocopy "vl" "%LIBRARY_INC%\vl" *.h /MIR

exit 0
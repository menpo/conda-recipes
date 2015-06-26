if %ARCH% EQU 32 (
  set LIB_KEY="X86"
  call "%VCINSTALLDIR%\vcvarsall.bat" x86
) else (
  set LIB_KEY="X64"
  call "%VCINSTALLDIR%\vcvarsall.bat" amd64
)


lib /machine:%LIB_KEY% /def:libfftw3l-3.def
lib /machine:%LIB_KEY% /def:libfftw3-3.def
lib /machine:%LIB_KEY% /def:libfftw3f-3.def

xcopy *.lib %LIBRARY_LIB%
xcopy *.dll %LIBRARY_BIN%
xcopy *.exe %LIBRARY_BIN%
xcopy *.h %LIBRARY_INC%
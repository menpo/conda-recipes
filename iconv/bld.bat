if %ARCH% EQU 64 (
    set LIBTOOL_KEY="X64"
    call "%VCINSTALLDIR%\vcvarsall.bat" amd64
) else (
    set LIBTOOL_KEY="X86"
    call "%VCINSTALLDIR%\vcvarsall.bat" x86
)

xcopy "%RECIPE_DIR%\*.def" .

7z x *.7z -r -y

rem Automatically generate the def file from libiconv dll
lib /machine:%LIBTOOL_KEY% /def:libiconv.def

rem Automatically generate the def file from the libcharset dll
lib /machine:%LIBTOOL_KEY% /def:libcharset.def

copy libiconv.lib "%LIBRARY_LIB%\libiconv.lib"
copy libcharset.lib "%LIBRARY_LIB%\libcharset.lib"
copy bin\libiconv-2.dll "%LIBRARY_BIN%\libiconv.dll"
copy bin\libcharset-1.dll "%LIBRARY_BIN%\libcharset.dll"
xcopy "bin\*.exe" %LIBRARY_BIN%
xcopy "include\*.h" "%LIBRARY_INC%" /e
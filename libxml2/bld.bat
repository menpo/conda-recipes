if %ARCH% EQU 64 (
    call "%VCINSTALLDIR%\vcvarsall.bat" amd64
    
    xcopy "%RECIPE_DIR%\*.def" .
    7z x libxml2-2.9.2-win32-x86_64.7z -r -y
    
    lib /machine:X64 /def:libxml2.def
    
    xcopy libxml2.lib %LIBRARY_LIB%
    copy bin\libxml2-2.dll %LIBRARY_BIN%\libxml2.dll
    xcopy bin\*.exe %LIBRARY_BIN%
    xcopy "include" "%LIBRARY_INC%" /e
) else (
    xcopy lib\*.lib %LIBRARY_LIB%
    xcopy bin\*.dll %LIBRARY_BIN%
    xcopy bin\*.exe %LIBRARY_BIN%
    robocopy include\libxml\ %LIBRARY_INC%\libxml2\libxml\
    
    exit 0
)


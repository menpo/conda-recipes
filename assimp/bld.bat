@echo off
rem Handle different architecture library files
if %ARCH%==64 (
    copy /y bin\assimp_release-dll_x64\*.dll %LIBRARY_BIN%\ > nul
    copy /y lib\assimp_release-dll_x64\*.lib %LIBRARY_LIB%\ > nul
)
if %ARCH%==32 (
    copy /y bin\assimp_release-dll_win32\*.dll %LIBRARY_BIN%\ > nul
    copy /y lib\assimp_release-dll_win32\*.lib %LIBRARY_LIB%\ > nul
)
rem Copy all of the include header files
xcopy include\assimp %LIBRARY_INC%\assimp /E /I > nul
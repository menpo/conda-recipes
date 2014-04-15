@echo off
copy /y bin\*.dll %PREFIX%\ > nul
copy /y bin\cmake.exe %PREFIX%\ > nul
xcopy share %PREFIX%\share /E /I > nul

@echo off
copy /y bin\*.dll %PREFIX%\ > nul
copy /y bin\*.exe %PREFIX%\ > nul
xcopy share %PREFIX%\share /E /I > nul
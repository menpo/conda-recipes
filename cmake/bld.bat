@echo off
xcopy bin %LIBRARY_BIN%\bin /E /I > nul
xcopy share %LIBRARY_BIN%\share /E /I > nul

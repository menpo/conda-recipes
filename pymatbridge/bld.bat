if %ARCH%==32 (
    set MLAB_ARCH="mexw32"
)
if %ARCH%==64 (
    set MLAB_ARCH="mexw64"
)

rem Build the messenger for each platform to make sure
rem everything is linked correctly. At the moment
rem this only builds Matlab because I do not have Octave installed.
cd pymatbridge\messenger
rem Make the directory if it doesn't exist (e.g. Windows 32-bit)
if NOT EXIST %MLAB_ARCH% (
    md %MLAB_ARCH%
)

rem Create the config file for ZMQ - let make.py work out Matlab path
"%PYTHON%" "%RECIPE_DIR%\write_config.py"
mv local.cfg "%MLAB_ARCH%\local.cfg"

rem Currently bug trying to build as c - move to cpp
rem This has already been patched in make.py in the meta.yaml
mv src\messenger.c src\messenger.cpp

rem Build statically on Windows
"%PYTHON%" make.py matlab
#"%PYTHON%" make.py octave

rem Quit early if making messenger failed
if %errorlevel% neq 0 exit /b %errorlevel%

cd ../..
"%PYTHON%" setup.py install

if %errorlevel% neq 0 exit /b %errorlevel%

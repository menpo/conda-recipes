
set CONDA_GLEW_DIR=%LIBRARY_PREFIX%
set CONDA_GLFW_DIR=%LIBRARY_PREFIX%
"%PYTHON%" setup.py install
if errorlevel 1 exit 1

:: Add more build steps here, if they are necessary.

:: See
:: https://github.com/ContinuumIO/conda/blob/master/conda/builder/README.txt
:: for a list of environment variables that are set during the build process.

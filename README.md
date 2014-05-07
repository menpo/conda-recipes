conda-recipes
=============

The Conda recipes for our Python packages

Building Menpo
--------------

Be sure to update the version numbers of any updated packages, the URLS and MD5s in the yaml files.

You will need the following packages installed

    >> conda install conda-build binstar pip
    >>> pip install docopt
    
and now, after changing into the conda-recipes directory

    >> python build.py --help

Follow the instructions to build the packages. This assume that you either have conda installed in the global environment (pass no architecture flags) or have setup your environment to allow switching between architectures. In this case the build script looks for commands of the form `conda32` and `conda64` which should properly activate the conda environment.

Building in a Virtual Machine
-----------------------------

CyRasterize has tests which will fail if the machine does not have an OpenGL 3.0 capable graphics card, which poses a problem for building in a virutal machine. To avoid this, just set the `IN_VM=1` environment variable before building - then the tests will be skipped.

Uploading to Binstar
--------------------

Chdir to the conda-bld/win folder and then

    >> binstar -t API_KEY upload -u menpo menpo-pyvrml97-2.3.0a4-np18py27_0.tar.bz2

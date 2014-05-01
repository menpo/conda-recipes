conda-recipes
=============

The Conda recipes for our Python packages

Building Menpo
--------------

Be sure to update the version numbers of any updated packages, the URLS and MD5s in the yaml files.

You will need conda-build installed

    >> conda install conda-build
    
and now, after changing into the conda-recipes directory

    >> conda build cyrasterize cyassimp menpo-pyvrml97 menpo

Building in a Virtual Machine
-----------------------------

CyRasterize has tests which will fail if the machine does not have an OpenGL 3.0 capable graphics card, which poses a problem for building in a virutal machine. To avoid this, just set the `IN_VM=1` environment variable before building - then the tests will be skipped.

Uploading to Binstar
--------------------

Chdir to the conda-bld/win folder and then

    >> binstar -t API_KEY upload -u menpo menpo-pyvrml97-2.3.0a4-np18py27_0.tar.bz2

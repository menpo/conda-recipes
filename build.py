#! /usr/bin/env python
"""
Usage:
    build.py <package_names>... [--upload] [--force]
    build.py --version
    build.py -h | --help

Options:
   <package_names>...  The package names to build. Use 'all' to build all.
   --upload            Upload all packages to binstar
   --force             Force the uploads
   -h, --help          Show this help text
   --version           Show Version
"""
from __future__ import print_function
import subprocess
import platform
import sys
import os

from docopt import docopt


active_platform = platform.system()
is_windows = active_platform.lower() == 'windows'
all_packages_list = ['pathlib', 'assimp', 'cyassimp', 'glew', 'glfw3', 'cyrasterize',
                     'menpo-pyvrml97', 'menpo', 'aniso8601', 'flask-restful',
                     'flask-compress', 'landmarkerio-server']


def upload_package(package, force):
    from conda_build.metadata import MetaData
    from conda_build.build import bldpkg_path

    built_package_path = bldpkg_path(MetaData(package))

    print('Uploading {} from {}'.format(package, built_package_path))

    # Set up the binstar upload command
    command = ['binstar', 'upload', '-u', 'menpo']
    if force:
        command += ['--force']
    command += [built_package_path]
    print('Running command "{}"'.format(' '.join(command)))
    # Call binstar
    error_code = subprocess.call(command, shell=is_windows)
    if error_code != 0:
        if force or error_code != 1:
            raise EnvironmentError('Executing binstar upload failed with a '
                                   'return code of {}'.format(error_code))
    else:
        print('Successfully uploaded {}'.format(package))


def run(packages, upload, force):
    for package in packages:
        print('Beginning to build {}'.format(package))
        command = ['conda', 'build', package]
        print('Running command "{}"'.format(' '.join(command)))
        error_code = subprocess.call(command, shell=is_windows)
        if error_code != 0:
            raise EnvironmentError('Executing conda build failed with a '
                                   'return code of {}'.format(error_code))
        else:
            print('Successfully built {}'.format(package))

        if upload:
            upload_package(package, force)


if __name__ == '__main__':
    args = docopt(__doc__, version='0.0.1')

    # Try default conda
    try:
        error_code = subprocess.call(['conda', '-V'], shell=is_windows)
        if error_code != 0:
            raise EnvironmentError(
                '"conda" does not appear to be installed')
    except Exception as e:
        raise EnvironmentError('Failed to execute "conda"', e)

    # Check for package names or 'all'
    if (len(args['<package_names>']) == 1 and
        args['<package_names>'][0] == 'all'):
        packages = all_packages_list
    else:
        packages = args['<package_names>']

    run(packages, args['--upload'], args['--force'])

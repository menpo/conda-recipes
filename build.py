#! /usr/bin/env python
"""
Usage:
    build.py [<archs>...] [--upload] [--force]
    build.py --version
    build.py -h | --help

Options:
   <archs...>  Only 32 or 64 architectures currently supported
   --upload    Upload all packages to binstar
   --force     Force the uploads
   -h, --help  Show this help text
   --version   Show Version
"""
from __future__ import print_function
import subprocess
import platform
import sys
import os
from docopt import docopt


active_platform = platform.system()
is_windows = active_platform.lower() == 'windows'
packages_list = ['assimp', 'cyassimp', 'glew', 'glfw3', 'cyrasterize',
                 'menpo-pyvrml97', 'menpo']


def activate_environment(arch):
    conda_command = 'conda' + arch
    try:
        print('Attempting to switch to {}-bit conda using {}'.format(
            arch, conda_command))
        error_code = subprocess.call([conda_command], shell=is_windows)
        if error_code != 0:
            raise EnvironmentError('Failed to switch to the environment, '
                                   'are you sure that you have set up '
                                   'the version scripts?')
    except Exception as e:
        raise EnvironmentError('Failed to execute "{}"'.format(
            conda_command), e)


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
    error_code = subprocess.call(command, shell=is_windows)
    if error_code != 0:
        raise EnvironmentError('Executing binstar upload failed with a '
                               'return code of {}'.format(error_code))
    else:
        print('Successfully uploaded {}'.format(package))


def run(archs, upload, force):
    for arch in archs:
        # Try activate the architecture
        activate_environment(arch)

        for package in packages_list:
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

    # No archs passed, try default conda
    if len(args['<archs>']) == 0:
        try:
            error_code = subprocess.call(['conda', '-V'], shell=is_windows)
            if error_code != 0:
                raise EnvironmentError(
                    '"conda" does not appear to be installed')
        except Exception as e:
            raise EnvironmentError('Failed to execute "conda"', e)

    for p in args['<archs>']:
        if p not in ['32', '64']:
            raise ValueError('Accepted architectures are 32 and 64.')

    run(args['<archs>'], args['--upload'], args['--force'])

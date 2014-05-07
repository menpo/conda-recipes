import subprocess
import platform
import sys

platform = platform.system()
is_windows = platform == 'windows'
packages_list = ['assimp', 'cyassimp', 'glew', 'glfw3', 'cyrasterize',
                 'menpo-pyvrml', 'menpo']


def run():
    for package in packages_list:
        print('Beginning to build {}'.format(package))
        command = ['conda', 'build', package]
        print('Running command "{}"'.format(' '.join(command)))
        error_code = subprocess.call(command, shell=is_windows)
        if error_code != 0:
            raise EnvironmentError('Executing conda build failed with a '
                                   'return code of {}'.format(p.returncode))
        else:
            print('Successfuly built {}'.format(package))


if __name__ == '__main__':
    # No arguments passed
    if len(sys.argv) == 1:
        try:
            error_code = subprocess.call(['conda', '-v'], shell=is_windows)
            if error_code != 0:
                raise EnvironmentError('"conda" does not appear to be installed')
        except Exception as e:
                raise EnvironmentError('Failed to execute "conda"', e)
    if len(sys.argv) == 2:
        version = sys.argv[1]
        if version not in ['32', '64']:
            raise ValueError('Accepted arguments are 32 or 64.')
        try:
            conda_command = 'conda' + version
            print('Atempting to switch to {}-bit conda using {}'.format(
                version, conda_command))
            error_code = subprocess.call([conda_command], shell=is_windows)
            if error_code != 0:
                raise EnvironmentError('Failed to switch to the environment, '
                                       'are you sure that you have set up '
                                       'the version scripts?')
        except Exception as e:
                raise EnvironmentError('Failed to execute "{}"'.format(
                    conda_command), e)
    run()

from os.path import join
from os import environ
import platform

is_windows = platform.system().lower() == 'windows'

if __name__ == "__main__":
    if not is_windows:
        PREFIX_PATH = environ.get('PREFIX')
        INCLUDE_PATH = join(PREFIX_PATH, 'include')
        LIBRARY_PATH = join(PREFIX_PATH, 'lib')
    else:
        INCLUDE_PATH = environ.get('LIBRARY_INC')
        LIBRARY_PATH = environ.get('LIBRARY_LIB')
    
    # Let the make script guess the directory of Matlab and Octave
    config = r"""MATLAB_BIN=
OCTAVE_INC=
OCTAVE_LIB=
ZMQ_INC="{}"
ZMQ_LIB="{}"
""".format(INCLUDE_PATH, LIBRARY_PATH)
    
    with open('local.cfg', 'w') as f:
        f.write(config)


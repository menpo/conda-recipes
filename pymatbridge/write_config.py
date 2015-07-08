from os.path import join
from os import environ

if __name__ == "__main__":
    PREFIX_PATH = environ.get('PREFIX')
    INCLUDE_PATH = join(PREFIX_PATH, 'include')
    LIBRARY_PATH = join(PREFIX_PATH, 'lib')
    
    # Let the make script guess the directory of Matlab and Octave
    config = r"""MATLAB_BIN=
OCTAVE_INC=
OCTAVE_LIB=
ZMQ_INC={}
ZMQ_LIB={}
""".format(INCLUDE_PATH, LIBRARY_PATH)
    
    with open('local.cfg', 'w') as f:
        f.write(config)


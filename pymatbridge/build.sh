if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  if [ $ARCH -eq 64 ]; then
    MLAB_ARCH="mexa64"
  else
    MLAB_ARCH="mexa32"
  fi
fi
if [ "$(uname -s)" == "Darwin" ]; then
  MLAB_ARCH="mexmaci64"
fi


# Build the messenger for each platform to make sure
# everything is linked correctly. At the moment
# this only builds Matlab because I do not have Octave installed.
cd pymatbridge/messenger
# Make the directory if it doesn't exist (e.g. Linux 32-bit)
mkdir -p $MLAB_ARCH

# Create the config file for ZMQ - let make.py work out Matlab path
$PYTHON $RECIPE_DIR/write_config.py
mv local.cfg $MLAB_ARCH/local.cfg

# Currently bug trying to build as c - move to cpp
# This has already been patched in make.py in the meta.yaml
mv src/messenger.c src/messenger.cpp

$PYTHON make.py matlab
#$PYTHON make.py octave

cd ../..
"$PYTHON" setup.py install


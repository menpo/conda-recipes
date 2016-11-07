export LIBRARY_PATH="$PREFIX/lib"
export INCLUDE_PATH="$PREFIX/include"
export CFLAGS="-I$INCLUDE_PATH/suitesparse"
export LDFLAGS="-L$LIBRARY_PATH"

"$PYTHON" setup.py install --single-version-externally-managed --record=/tmp/record.txt

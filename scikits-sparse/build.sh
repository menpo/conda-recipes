export CFLAGS="-I$INCLUDE_PATH"
export LDFLAGS="-L$LIBRARY_PATH"

"$PYTHON" setup.py install --single-version-externally-managed --record=/tmp/record.txt

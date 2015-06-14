#!/bin/bash

# set protobuf installation path name

PROTOBUF_PATH="/unixC/protobuf"

# in case of compiling error 'required file `build/ltmain.sh' not found' 
libtoolize --automake --copy --debug --force

# execute autotools serial compile operations

cd $PROTOBUF && aclocal
cd $PROTOBUF && autoconf 
cd $PROTOBUF && autoheader 

cd $PROTOBUF && automake --add-missing

# compile prefer setting 
$PROTOBUF_PATH/configure --prefix=/usr/local

echo "finish setting , now we begin make && make install protobuf .... "

# make and make install protobuf
cd $PROTOBUF_PATH  && make && make install 

echo "protobuf installation finish !"

echo 
echo

echo "let us update the system shared library"
ldconfig

echo 
echo 
echo "let us check whether protoc [protobuf compiler] can run on this platform"
protoc


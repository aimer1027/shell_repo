#!/bin/bash

# set protobuf installation path name

PROTOBUF_PATH="/unixC/protobuf"


git clone from self github branch 

echo "git clone protobuf, wait ....."
echo

git clone git@github.com:aimer1027/protobuf.git $PROTOBUF_PATH

echo "gin clone finish .... begin running autogen.sh script .... " 
echo

mkdir $PROTOBUF_PATH

echo "git clone gtest "
echo

git clone git@github.com:kgcd/gtest.git $PROTOBUF_PATH/gtest

echo "configure and compile && install gtest "
echo

$PROTOBUF_PATH/gtest/configure --prefix=/usr/local/gtest

cd /unixC/protobuf/gtest && make && make install

echo "---------------- gtest installation finish ----------------------"
echo 
echo 
echo "now ,change 1. configure.ac under ../protobuf/ "
echo "and common.cc source file under ../protobuf/src/google/protobuf/stub/"


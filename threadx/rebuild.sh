#!/bin/bash

mkdir -p "build" # create if it doesn't exist
pushd build
if [ "$?" -ne "0" ]; then
    echo "Error creating build directory"
fi

rm -rf *
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/arm-gcc-toolchain.cmake ..
make

popd
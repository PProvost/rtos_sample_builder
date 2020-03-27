#!/bin/bash

mkdir -p "build" # create if it doesn't exist
pushd build
if [ "$?" -ne "0" ]; then
    echo "Error creating build directory"
fi

# Clean up the build folder
rm -rf *

# Run cmake in the project root directory, using the toolchain
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/arm-gcc-toolchain.cmake ..

# Run make to finish things off and generate our .bin file
make

popd
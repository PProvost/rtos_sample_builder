#!/bin/bash

pushd build

rm -rf *
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/arm-gcc-toolchain.cmake ..
make

popd
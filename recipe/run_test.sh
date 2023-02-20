#!/bin/bash

set -ex

ls
cd test
ln -sf ${GXX} g++
cp ../xcrun .
cp ../xcodebuild .
export PATH=${PWD}:${PATH}
if [[ $(uname) == "Linux" ]]; then
    qmake                         \
        QMAKE_CXX="${CXX}"        \
        QMAKE_LINK="${CXX}"       \
        QMAKE_LFLAGS="${LDFLAGS}" \
        hello.pro
else
    qmake hello.pro
fi
make
./hello
# Only test that this builds
make clean

if [[ $(uname) == "Linux" ]]; then
    qmake                         \
        QMAKE_CXX="${CXX}"        \
        QMAKE_LINK="${CXX}"       \
        QMAKE_LFLAGS="${LDFLAGS}" \
        test_qmimedatabase.pro
else
    qmake test_qmimedatabase.pro
fi
make
./test_qmimedatabase
make clean

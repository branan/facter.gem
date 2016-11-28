#!/bin/bash
export WINEPATH="/usr/i686-w64-mingw32/lib;/usr/lib/gcc/i686-w64-mingw32/4.8"

rm -fr /tmp/nwlin /tmp/nw

pushd .
./convert && mkdir nowide/build && cd nowide/build && cmake -DCMAKE_TOOLCHAIN_FILE=../../MinGW.cmake -DCMAKE_INSTALL_PREFIX=/tmp/nw -DRUN_WITH_WINE=ON .. && make && make test && make install
popd 

pushd .

./convert && mkdir nowide/build && cd nowide/build && cmake -DLIBDIR=lin64 -DCMAKE_INSTALL_PREFIX=/tmp/nwlin .. && make && make test && make install

popd






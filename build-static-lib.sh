
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE

# brotli
cd $WORKSPACE
git clone https://github.com/google/brotli.git 
cd brotli
mkdir build
cd build
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=MinSizeRel -DBUILD_SHARED_LIBS=OFF .. 
ninja && ninja install


# libinjection
cd $WORKSPACE
git clone https://github.com/libinjection/libinjection.git
cd libinjection
./autogen.sh
LDFLAGS="-static --static -no-pie -s" ./configure --prefix=/usr
make
make install


# LMDB
cd $WORKSPACE
git clone https://github.com/LMDB/lmdb
cd lmdb/libraries/liblmdb
make
make install

# ssdeep
git clone https://github.com/ssdeep-project/ssdeep.git
cd ssdeep
./bootstrap
LDFLAGS="-static --static -no-pie -s" ./configure --prefix=/usr
make
make install

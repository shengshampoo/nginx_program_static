
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
cd $WORKSPACE
git clone https://github.com/ssdeep-project/ssdeep.git
cd ssdeep
./bootstrap
LDFLAGS="-static --static -no-pie -s" ./configure --prefix=/usr
make
make install

# libxml
cd $WORKSPACE
aa=2.13.8 
curl -sL https://gitlab.gnome.org/GNOME/libxml2/-/archive/v$aa/libxml2-v$aa.tar.bz2 | tar xv --bzip2
cd libxml2-v$aa
sh autogen.sh
LDFLAGS="-static --static -no-pie -s" ./configure --prefix=/usr --enable-static --disable-shared
make
make install

# c-ares
cd $WORKSPACE
git clone https://github.com/c-ares/c-ares.git
cd c-ares
./buildconf
LDFLAGS="-static --static -no-pie -s" ./configure  --prefix=/usr --disable-shared --disable-libgcc
make
make install

# curl
cd $WORKSPACE
git clone https://github.com/curl/curl.git
cd curl
autoreconf -fi
CFLAGS=-static LDFLAGS="-static --static -no-pie -s -lnghttp2 -lidn2 -lssh2 -lpsl -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon" ./configure --prefix=/usr --with-openssl --disable-shared --with-libidn2 --disable-docs --with-libpsl --with-libssh2 --enable-ares
make
make install

# ModSecurity
cd $WORKSPACE
git clone -b v3/master --single-branch https://github.com/SpiderLabs/ModSecurity.git
cd ModSecurity
git submodule init
git submodule update
./build.sh
LDFLAGS="-static --static -no-pie -s -lcrypt" ./configure --prefix=/usr --with-yajl --with-lua --with-pcre2 --with-ssdeep --with-lmdb
make
make install

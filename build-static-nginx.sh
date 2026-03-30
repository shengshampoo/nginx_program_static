
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace2
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# For termux dictionary
mkdir -p /data/data/com.termux/files/usr

# nginx
cd $WORKSPACE
git clone https://github.com/nginx/nginx
cd nginx
./auto/configure --prefix=/usr/local/nginxmm \
  --with-poll_module --with-file-aio --with-threads \
  --with-http_ssl_module --with-http_v2_module \
  --with-http_dav_module --with-http_mp4_module \
  --with-http_gzip_static_module --with-stream --with-stream_realip_module \
  --with-stream_ssl_module --with-stream_ssl_preread_module \
  --with-http_realip_module --with-pcre --with-pcre-jit \
  --with-openssl-opt=enable-ktls --with-libatomic \
  --with-cc-opt='-std=gnu17 -O3 -fno-pie -no-pie -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -fno-pie -no-pie -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/$(find / -maxdepth 1 -type d -name "openssl-*" -exec basename {} \;) --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

make
make install

# angie
# https://en.angie.software/angie/docs/development/
cd $WORKSPACE
git clone https://git.angie.software/web-server/angie 
cd angie
./configure --prefix=/usr/local/angiemm \
  --with-poll_module --with-file-aio --with-threads \
  --with-http_ssl_module --with-http_v2_module \
  --with-http_dav_module --with-http_mp4_module \
  --with-http_gzip_static_module --with-stream --with-stream_realip_module \
  --with-stream_ssl_module --with-stream_ssl_preread_module \
  --with-http_realip_module --with-pcre --with-pcre-jit \
  --with-openssl-opt=enable-ktls --with-libatomic \
  --with-cc-opt='-std=gnu17 -O3 -fno-pie -no-pie -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -fno-pie -no-pie -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/$(find / -maxdepth 1 -type d -name "openssl-*" -exec basename {} \;) --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

make
make install


# termux

# https://github.com/HomuHomu833/android-ndk-custom
cd /
curl -sL "https://github.com/HomuHomu833/android-ndk-custom/releases/download/r29/android-ndk-r29-$(uname -m)-linux-musl.tar.xz" | tar x --xz

export CC="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android23-clang"
export CXX="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android23-clang++"
export AR="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
export AS=$CC
export LD="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/ld"
export RANLIB="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib"
export STRIP="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip"
export PATH=/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/:$PATH
export ANDROID_NDK_HOME="/android-ndk-r29"
export ANDROID_NDK="/android-ndk-r29"
export ANDROID_NDK_ROOT="/android-ndk-r29"


# nginx for termux
cd $WORKSPACE
rm -r nginx
git clone https://github.com/nginx/nginx
cd nginx
sed -i '21d' auto/cc/name
./auto/configure --prefix=/data/data/com.termux/files/usr/nginxtx \
  --with-poll_module --with-file-aio --with-threads \
  --with-http_ssl_module --with-http_v2_module \
  --with-http_dav_module --with-http_mp4_module \
  --with-http_gzip_static_module --with-stream --with-stream_realip_module \
  --with-stream_ssl_module --with-stream_ssl_preread_module \
  --with-http_realip_module --with-pcre --with-pcre-jit \
  --with-openssl-opt=enable-ktls --with-libatomic \
  --with-cc="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/clang" \
  --with-cc-opt='-std=gnu17 -O3 -fno-pie -no-pie -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -fno-pie -no-pie -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/$(find / -maxdepth 1 -type d -name "openssl-*" -exec basename {} \;) --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

make
make install

# angie for termux
cd $WORKSPACE
rm -r angie
git clone https://git.angie.software/web-server/angie 
cd angie
./configure --prefix=/data/data/com.termux/files/usr/angietx \
  --with-poll_module --with-file-aio --with-threads \
  --with-http_ssl_module --with-http_v2_module \
  --with-http_dav_module --with-http_mp4_module \
  --with-http_gzip_static_module --with-stream --with-stream_realip_module \
  --with-stream_ssl_module --with-stream_ssl_preread_module \
  --with-http_realip_module --with-pcre --with-pcre-jit \
  --with-openssl-opt=enable-ktls --with-libatomic \
  --with-cc="/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin/clang" \
  --with-cc-opt='-std=gnu17 -O3 -fno-pie -no-pie -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -fno-pie -no-pie -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/$(find / -maxdepth 1 -type d -name "openssl-*" -exec basename {} \;) --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

make
make install



cd /usr/local
tar vcJf ./nginxmm.tar.xz nginxmm
tar vcJf ./angiemm.tar.xz angiemm

mv ./[an]*mm.tar.xz /work/artifact/

cd /data/data/com.termux/files/usr
tar vcJf ./nginxtx.tar.xz nginxtx
tar vcJf ./angietx.tar.xz angietx

mv ./[an]*tx.tar.xz /work/artifact/

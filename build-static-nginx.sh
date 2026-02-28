
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace2
WORKSPACE3=/tmp/workspace3
mkdir -p $WORKSPACE
mkdir -p $WORKSPACE3
mkdir -p /work/artifact

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
  --with-cc-opt='-O3 -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/$(find / -maxdepth 1 -type d -name "openssl-*" -exec basename {} \;) --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

make
make install

# freenginx
#cd $WORKSPACE3
# hg clone http://freenginx.org/hg/nginx 
#cd nginx
#./auto/configure --prefix=/usr/local/nginxfmm \
  --with-poll_module --with-file-aio --with-threads \
  --with-http_ssl_module --with-http_v2_module \
  --with-http_dav_module --with-http_mp4_module \
  --with-http_gzip_static_module --with-stream --with-stream_realip_module \
  --with-stream_ssl_module --with-stream_ssl_preread_module \
  --with-http_realip_module --with-pcre --with-pcre-jit \
  --with-openssl-opt=enable-ktls --with-libatomic \
  --with-cc-opt='-O3 -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/$(find / -maxdepth 1 -type d -name "openssl-*" -exec basename {} \;) --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

#make
#make install

# angie
# https://en.angie.software/angie/docs/development/
cd $WORKSPACE
git clone https://git.angie.software/web-server/angie 
cd angie
./auto/configure --prefix=/usr/local/angiemm \
  --with-poll_module --with-file-aio --with-threads \
  --with-http_ssl_module --with-http_v2_module \
  --with-http_dav_module --with-http_mp4_module \
  --with-http_gzip_static_module --with-stream --with-stream_realip_module \
  --with-stream_ssl_module --with-stream_ssl_preread_module \
  --with-http_realip_module --with-pcre --with-pcre-jit \
  --with-openssl-opt=enable-ktls --with-libatomic \
  --with-cc-opt='-O3 -Wno-error -DNGX_QUIC_OPENSSL_API=1' \
  --with-ld-opt='-static -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lssl -lcrypto -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
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
tar vcJf ./nginxfmm.tar.xz nginxfmm
tar vcJf ./angiemm.tar.xz angiemm

mv ./[an]*mm.tar.xz /work/artifact/

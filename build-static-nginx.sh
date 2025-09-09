
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace2
mkdir -p $WORKSPACE
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
  --with-ld-opt='-static -lgcov -lstdc++ -lmodsecurity -lyajl -lxml2 -llmdb -lfuzzy -L/usr/lib/lua5.4 -llua -lcurl -lcares -lnghttp2 -lidn2 -lpsl -lssh2 -lunistring -lbrotlienc -lbrotlidec -lbrotlicommon -lxslt' \
  --with-openssl=/openssl-3.5.2 --with-http_v3_module \
  --with-http_addition_module --add-module=/ngx_brotli \
  --add-module=/zstd-nginx-module --add-module=/ngx_http_geoip2_module \
  --add-module=/nginx-vod-module --add-module=/nginx-http-flv-module \
  --add-module=/nginx-module-vts --add-module=/ModSecurity-nginx \
  --add-module=/njs/nginx --with-http_gzip_static_module

make
make install

cd /usr/local
tar vcJf ./nginxmm.tar.xz nginxmm

mv ./nginxmm.tar.xz /work/artifact/

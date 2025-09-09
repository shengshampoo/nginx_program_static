FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

# required nginx 
RUN apk add --no-cache \
 gcc make linux-headers musl-dev zlib-dev zlib-static \
 python3-dev curl zstd-static zstd-dev openssl-dev openssl-libs-static \
 g++ git libuv-static libuv-dev pcre-dev pcre-static pcre2-dev pcre2-static \
 libmaxminddb-static libmaxminddb-dev luajit-dev luajit libunistring-static \ 
 libunistring-dev cmake ninja perl libatomic_ops-static libatomic_ops-dev \
 autoconf automake libtool libxslt-static libxslt-dev patch aria2

# required to compile ModSecurity as static lib
RUN apk add --no-cache \
 ssdeep ssdeep-static yajl-dev yajl-static yajl \
 lua5.4-dev xz-static xz-dev libidn2-static \
 libidn2-dev nghttp2-static nghttp2-dev \
 libpsl-static libpsl-dev libssh2-dev libssh2-static

RUN aria2c -x2 -R https://raw.githubusercontent.com/shengshampoo/nginx_program_static-rust_program_static/refs/heads/main/build-ngx-addon.sh && \
 chmod +x build-ngx-addon.sh && ./build-ngx-addon.sh


RUN aria2c -x2 -R https://raw.githubusercontent.com/shengshampoo/nginx_program_static-rust_program_static/refs/heads/main/build-static-lib.sh && \
 chmod +x build-static-lib.sh && ./build-static-lib.sh


#! /bin/bash

set -e

cd /
git clone https://github.com/google/ngx_brotli 
cd /ngx_brotli && git submodule update --init 

cd / 
git clone https://github.com/tokers/zstd-nginx-module
git clone https://github.com/leev/ngx_http_geoip2_module
git clone https://github.com/kaltura/nginx-vod-module
git clone https://github.com/winshining/nginx-http-flv-module
git clone https://github.com/vozlt/nginx-module-vts
git clone https://github.com/owasp-modsecurity/ModSecurity-nginx
git clone https://github.com/nginx/njs

curl -sL https://github.com/openssl/openssl/releases/download/openssl-3.5.2/openssl-3.5.2.tar.gz | tar vx --gzip

#!/bin/bash

wget 'http://openresty.org/download/ngx_openresty-1.7.2.1.tar.gz'
tar xzvf ngx_openresty-1.7.2.1.tar.gz
cd ngx_openresty-1.7.2.1

./configure
make
make install



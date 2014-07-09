#!/bin/bash

PATH=/usr/local/openresty/nginx/sbin:$PATH
export PATH

nginx -p `pwd`/ -c conf/nginx.conf

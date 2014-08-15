#!/bin/bash
wget http://download.redis.io/releases/redis-2.8.13.tar.gz
tar xzvf redis-2.8.13.tar.gz
cd redis-2.8.13

make
make install


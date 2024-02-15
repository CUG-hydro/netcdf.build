# /bin/bash
wget https://github.com/curl/curl/releases/download/curl-8_6_0/curl-8.6.0.tar.gz
tar -xvf curl-8.6.0.tar.gz
cd curl-8.6.0

./configure
make -j
sudo make install

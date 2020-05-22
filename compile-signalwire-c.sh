#!/usr/bin/bash

export PACKAGE_RELEASE=1
source /etc/profile
source ~/.bashrc

git clone https://github.com/signalwire/signalwire-c.git
cd signalwire-c
cmake .
cmake build .
cpack
sudo dpkg -i signalwire-client-c_*.deb

mkdir -p ../.packages
mv *.deb ../.packages



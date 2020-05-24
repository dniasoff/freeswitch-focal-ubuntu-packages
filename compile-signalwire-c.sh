#!/usr/bin/bash

export PACKAGE_RELEASE=1

git clone https://github.com/signalwire/signalwire-c.git
cd signalwire-c
cmake .
cmake build .
cpack
sudo dpkg -i --force-all signalwire-client-c_*.deb

mkdir -p ../.packages
mv *.deb ../.packages



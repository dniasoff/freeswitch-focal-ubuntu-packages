#!/usr/bin/bash

export PACKAGE_RELEASE=1

git clone https://github.com/signalwire/libks.git
cd libks
cmake .
cmake build .
cpack
sudo  dpkg -i --force-all libks_*.deb

mkdir -p ../.packages
mv *.deb ../.packages

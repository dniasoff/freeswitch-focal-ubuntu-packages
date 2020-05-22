#!/usr/bin/bash

export PACKAGE_RELEASE=1
source /etc/profile
source ~/.bashrc


git clone https://github.com/signalwire/libks.git
cd libks
cmake .
cmake build .
cpack
sudo  dpkg -i libks_*.deb

mkdir -p ../.packages
mv *.deb ../.packages
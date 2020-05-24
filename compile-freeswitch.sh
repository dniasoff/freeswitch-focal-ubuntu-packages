#!/usr/bin/bash


mkdir freeswitch_build
cd freeswitch_build

git clone https://github.com/signalwire/freeswitch.git -b v1.10
cd freeswitch
git config pull.rebase true
patch -p1 < ../../freeswitch_focal.patch
cd debian
./bootstrap.sh
cd ..
DEB_BUILD_OPTIONS="parallel=$(nproc)" debuild -b -uc -us
cd ..
rm -f *dbg*.deb

mkdir -p ../.packages
mv *.deb ../.packages

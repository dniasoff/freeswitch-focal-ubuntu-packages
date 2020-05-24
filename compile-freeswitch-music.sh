#!/usr/bin/bash

set -e

mkdir freeswitch-music_build
cd freeswitch-music_build


git clone https://github.com/traviscross/freeswitch-sounds.git
cd freeswitch-sounds
./debian/bootstrap.sh -p freeswitch-music-default
./debian/rules get-orig-source
tar -xv --strip-components=1 -f *_*.orig.tar.xz && mv *_*.orig.tar.xz ../
dpkg-buildpackage -uc -us -Zxz -z9

cd ..
mkdir -p ../.packages
mv *.deb ../.packages


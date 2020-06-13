#!/bin/bash
shopt -s dotglob

TMP=$(mktemp -d)

cd $HOME
cp -r * $TMP
cd $TMP
makepkg --nobuild --nodeps
tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve
mv src.tar.zst /home/build

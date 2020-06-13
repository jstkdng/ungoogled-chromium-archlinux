#!/bin/bash
shopt -s dotglob
cp -r * /home/build
chown -R build /home/build
su build
cd /home/build
makepkg --nobuild --nodeps
tar caf srcdir.tar.zst src/ --remove-file -H posix --atime-preserve

#!/bin/bash
shopt -s dotglob

cd $HOME
makepkg --nobuild --nodeps
tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve

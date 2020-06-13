#!/bin/bash
cd $HOME
makepkg --nobuild --nodeps
tar caf srcdir.tar.zst src/ --remove-file -H posix --atime-preserve

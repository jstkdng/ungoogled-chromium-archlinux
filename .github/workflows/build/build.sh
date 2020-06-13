#!/bin/bash
cd $HOME
timeout -k 10m -s SIGTERM 5h makepkg --noextract --nodeps
tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve

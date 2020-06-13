#!/bin/bash
cd $HOME
echo " ==== Building ===="
timeout -k 10m -s SIGTERM 5h makepkg --noextract --nodeps --noarchive
echo " ==== Creating src archive ===="
tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve
echo " ==== Resulting file sizes ===="
du -shc *

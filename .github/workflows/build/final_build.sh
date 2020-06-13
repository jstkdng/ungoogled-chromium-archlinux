#!/bin/bash
cd $HOME
timeout -k 10m -s SIGTERM 5h makepkg --noextract --nodeps
mkdir artifacts
sha256sum *.pkg.tar.zst
mv *.pkg.tar.zst artifacts/

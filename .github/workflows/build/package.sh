#!/bin/bash
cd $HOME
echo " ==== Creating package ===="
makepkg --repackage --nodeps
echo " ==== sha256sum of resulting package ==== "
sha256sum *.pkg.tar.zst
echo " ==== Moving package to artifacts folder ==== "
mkdir artifacts
mv *.pkg.tar.zst artifacts/

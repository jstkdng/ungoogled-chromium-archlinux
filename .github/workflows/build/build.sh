#!/bin/bash

cd /home/build

echo "==> Resuming build..."
timeout -k 10m -s SIGTERM 310m makepkg --noextract --nodeps

if compgen -G "*.pkg.tar.xz" > /dev/null; then
    echo "==> Checksum of built package:"
    sha256sum *.pkg.tar.zst

    echo "==> Moving package to artifacts folder"
    mkdir res
    mv *.pkg.tar.zst res/
else
    bash .github/workflows/build/upload_source.sh
fi

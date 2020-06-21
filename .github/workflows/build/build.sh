#!/bin/bash

cd $HOME

echo "==> Resuming build..."
timeout -k 10m -s SIGTERM 310m makepkg --noextract --nodeps

if compgen -G "*.pkg.tar.xz" > /dev/null; then
    echo "==> Checksum of built package:"
    sha256sum *.pkg.tar.zst

    echo "==> Moving package to artifacts folder"
    mkdir artifacts
    mv *.pkg.tar.zst artifacts/
else
    echo "==> Size of src/ directory"
    du -shc src/

    echo "==> Creating source archive..."
    tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve

    echo "==> Size of source archive:"
    du -shc src.tar.zst

    echo "==> Checksum of source archive"
    sha256sum src.tar.zst

    echo "==> Uploading source archive..."
    curl -F "file=@src.tar.zst" https://file.io | jq -r '.link' | tee src.txt
fi

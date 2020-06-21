#!/bin/bash
shopt -s dotglob

cd $HOME

echo "==> Prepairing sources..."
makepkg --nobuild --nodeps

echo "==> Size of src/ directory"
du -shc src/

echo "==> Creating source archive... "
tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve

echo "==> Size of source archive"
du -shc src.tar.zst

echo "==> Checksum of source archive"
sha256sum src.tar.zst

echo "==> Uploading source archive..."
curl -F "file=@src.tar.zst" https://file.io | jq -r ".link" | tee src.txt

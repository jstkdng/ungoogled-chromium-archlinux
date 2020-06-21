#!/bin/bash

cd src/

echo "==> Downloading source archive..."
curl -o src.tar.zst $(< src.txt)

echo "==> Checksum of source archive"
sha256sum src.tar.zst

echo "==> Extracting source archive..."
tar -xf src.tar.zst -C /home/build

echo "==> Deleting source archive..."
rm src.tar.zst

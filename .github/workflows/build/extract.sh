#!/bin/bash

cd res/

echo "==> Downloading source archive..."
curl -o src.tar.zst $(< url.txt)

echo "==> Verifying sums..."
sha256sum -c sums.txt

echo "==> Extracting source archive..."
tar -xf src.tar.zst -C /home/build

echo "==> Deleting source archive..."
rm src.tar.zst

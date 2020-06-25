#!/bin/bash

cd /home/build

mkdir res

echo "==> Size of src/ directory"
du -shc src/

echo "==> Creating source archive... "
tar caf src.tar.zst src/ --remove-file -H posix --atime-preserve

echo "==> Checksum of source archive"
sha256sum src.tar.zst | tee res/sums.txt

echo "==> Uploading source archive..."

SERVER="https://$(curl https://apiv2.gofile.io/getServer | jq '.data.server' | tr -d '"').gofile.io"
CODE=$(curl -XPOST -F filesUploaded=@src.tar.zst "$SERVER/upload" | jq '.data.code' | tr -d '"')
ENABLE="https://gofile.io/d/$CODE"

python .github/workflows/build/enable_download.py "$ENABLE"

echo "$SERVER/download/$CODE/src.tar.zst" | tee res/url.txt

rm src.tar.zst

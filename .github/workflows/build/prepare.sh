#!/bin/bash
set -e
shopt -s dotglob

cd /home/build

echo "==> Prepairing sources..."
makepkg --nobuild --nodeps

bash .github/workflows/upload_source.sh

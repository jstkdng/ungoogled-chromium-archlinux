#!/bin/bash

install_deps() {
    # install make package dependencies
    grep -E 'makedepends' PKGBUILD | \
        sed -e 's/.*depends=//' -e 's/ /\n/g' | \
        tr -d "'" | tr -d "(" | tr -d ")" | \
        xargs yay -S --noconfirm
}

sudo pacman -Syu --noconfirm

sudo chown -R build:build /build
cp /github/workspace/* /build/
cd /build/
install_deps
makepkg --nobuild --nodeps --clean

ret=$?
if [ $ret -ne 0 ]; then
    echo "Failed prepairing PKGBUILD"
    exit 1
fi

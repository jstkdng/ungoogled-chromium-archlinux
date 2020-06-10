#!/bin/bash

#tail -F .github/workflows/logfile&
tail -F logfile&

while true; do
    if compgen -G "*.pkg.tar.zst" > /dev/null; then
        exit 0
    else
        sleep 2
    fi
done

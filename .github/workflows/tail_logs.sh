#!/bin/bash

#tail -F .github/workflows/logfile&
tail -F $GITHUB_WORKSPACE/logfile&

while true; do
    if compgen -G "*.pkg.tar.zst" > /dev/null; then
        exit 0
    else
        sleep 2
    fi
done

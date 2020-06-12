#!/bin/bash

# pwd is $HOME/repo

function logs()
{
    echo "==== $@ ====" |& tee -a $LOGFILE
}

function logc()
{
    $@ |& tee -a $LOGFILE
}

# change permissions
sudo chown -R build $HOME/repo

# update packages
logc sudo pacman -Syu --noconfirm

# append to log
if [ -z ${RESUME+x} ]; then
    logs "Starting build..."
else
    logs "Resuming build..."
fi

# set build flags
ADD_FLAGS="--noextract"
if [ -z ${RESUME+x} ]; then
    ADD_FLAGS=""
fi

# start build
logc timeout -k 10m -s SIGTERM 5h makepkg --nodeps $ADD_FLAGS

if ls *.pkg.tar.zst 1> /dev/null 2>&1; then
    logs "Resulting sums of the file"
    logc sha256sum *.pkg.tar.zst
fi

# signal build finished
logs "Done building"
touch done_build

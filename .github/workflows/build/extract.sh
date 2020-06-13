#!/bin/bash
cd src
tar --sameowner -xf src.tar.zst -C /home/build
rm src.tar.zst

#!/bin/bash
sudo apt -y install wireguard-tools

TMP=$(mktemp -d)
cd $TMP
CONF="$(printf $WGCONF | base64 -d)"
echo "$CONF" > wg0.conf
sudo wg-quick up $PWD/wg0.conf
cd $HOME
rm -r $TMP

#!/bin/bash
#sudo add-apt-repository -y ppa:wireguard/wireguard
sudo apt -y install wireguard

TMP=$(mktemp -d)
cd $TMP
CONF="$(printf $WGCONF | base64 -d)"
echo "$CONF" > wg0.conf
sudo wg-quick up $PWD/wg0.conf

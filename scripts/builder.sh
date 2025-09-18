#!/bin/sh

echo "NixOS rebuild requires root permissions."
sudo -- sh -c './scripts/build.sh'
sudo -k

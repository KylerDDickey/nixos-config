#!/bin/sh

# Copy relevant files to the nix config directory.
cp flake.nix /etc/nixos/;
cp -r hosts/ /etc/nixos/;
cp -r modules/ /etc/nixos/;
cp -r overlays/ /etc/nixos/;

# Perform the build action.
# TODO: Make the profile selectable when there's more than
# one implemented.
nixos-rebuild switch --flake /etc/nixos/#personalLaptop;

# Copy back the lock file written to the config directory.
cp /etc/nixos/flake.lock ./;

# Copy relevant files to the nix config directory.
sudo cp flake.nix /etc/nixos/;
sudo cp -r hosts/ /etc/nixos/;
sudo cp -r modules/ /etc/nixos/;
sudo cp -r overlays/ /etc/nixos/;

# Perform the build action.
# TODO: Make the profile selectable when there's more than
# one implemented.
sudo nixos-rebuild switch --flake /etc/nixos/#personalLaptop;

# Copy back the lock file written to the config directory.
sudo cp /etc/nixos/flake.lock ./;

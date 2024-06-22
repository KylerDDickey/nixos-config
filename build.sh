sudo cp -TRv ./config /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos/#default

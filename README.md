# NixOS Config

## Install instructions

To get started with a fresh install of NixOs, run this command in the home directoy:

```bash
mkdir git; cd git; nix-shell -p git; git clone --recurse-submodules https://github.com/KylerDDickey/nixos-config.git; cd nixos-config; sudo chmod 755 build.sh; cd ..; sudo cp -TRv ./nixos-config /etc/nixos; ./build.sh;
```
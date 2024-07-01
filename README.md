# NixOS Config

## Install instructions

To get started with a fresh install of NixOs without Git, you can start a new shell with Git installed:

```bash
nix-shell -p git
```

Then clone this repository:

```bash
git clone --recurse-submodules https://github.com/KylerDDickey/nixos-config.git;
```

You can then install this configuration by running the build script:

```bash
./build.sh
```

This will recursively copy the relevant directories in this repository to `/etc/nixos`, run a build script using the flakes feature, and then copy the lock file back to this repository. You may need to restart after installing this configuration under certain circumnstances. If you do not see the changes you'd expect, start with a

```bash
sudo systemctl reboot
```

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

You can then install this configuration by first entering the nix develop shell:

```bash
nix develop
```

Then you may run the build script defined in the Nix shell hook:

```bash
build_nixos
```

This will recursively copy the relevant directories in this repository to `/etc/nixos`, run a build script using the flakes feature, and then copy the lock file back to this repository. You may need to restart after installing this configuration under certain circumnstances. If you do not see the changes you'd expect, try rebooting your system.

```bash
sudo systemctl reboot
```

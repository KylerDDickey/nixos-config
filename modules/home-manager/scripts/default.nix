{ pkgs, ... }@inputs:
let
  writeApps = i: map ({ value, ... }: value) (pkgs.lib.attrsToList (import i inputs));

  apps = {
    sysconf-nix = writeApps ./sysconf-nixos;
  };
in
{
  home.packages = pkgs.lib.lists.flatten (
    with apps;
    [
      sysconf-nix
    ]
  );
}

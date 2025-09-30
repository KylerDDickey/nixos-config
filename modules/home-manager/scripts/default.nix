{ outputs, pkgs, ... }:
let
  app = pkgs.writeShellApplication;

  sysconf-nix-channels-update = app {
    name = "sysconf-nix-channels-update";
    text = ''
      nix flake update --flake ${outputs.meta.rootPath};
    '';
  };
in
{
  home.packages = [
    sysconf-nix-channels-update
  ];
}

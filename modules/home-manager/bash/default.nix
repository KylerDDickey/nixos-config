{ pkgs, ... }:
{
  home.packages = with pkgs; [ direnv ];

  home.file = {
    ".bash_profile" = {
      source = ./.bash_profile;
    };
    ".bashrc" = {
      source = ./.bashrc;
    };
  };
}

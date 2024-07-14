{ pkgs, ... }:
{
  home.packages = [ pkgs.oh-my-posh ];

  home.file = {
    ".zshrc" = {
      source = ./.zshrc;
    };
    "theme.omp.json" = {
      source = ./theme.omp.json;
    };
  };
}

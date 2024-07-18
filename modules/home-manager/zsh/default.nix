{ pkgs, ... }:
{
  home.packages = with pkgs; [
    direnv
    fzf
    oh-my-posh
  ];

  home.file = {
    ".zshrc" = {
      source = ./.zshrc;
    };
    "theme.omp.json" = {
      source = ./theme.omp.json;
    };
  };
}

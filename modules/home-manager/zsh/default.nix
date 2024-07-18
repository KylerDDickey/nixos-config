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
    ".zsh-theme.omp.json" = {
      source = ./.zsh-theme.omp.json;
    };
  };
}

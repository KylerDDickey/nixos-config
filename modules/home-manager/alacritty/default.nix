{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };

  xdg.configFile = {
    "./alacritty/alacritty.toml" = {
      source = ./alacritty.toml;
    };

    "./alacritty/catppuccin-mocha.toml" = {
      source = ./catppuccin-mocha.toml;
    };
  };
}

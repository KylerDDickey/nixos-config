{ pkgs, ... }:

{
  home.packages = with pkgs; [ gcc nixfmt ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;
  };

  xdg.configFile = {
    "./nvim/lua" = {
      source = ./nvim/lua;
      recursive = true;
    };

    "./nvim/ftplugin" = {
      source = ./nvim/ftplugin;
      recursive = true;
    };

    "./nvim/init.lua" = { source = ./nvim/init.lua; };
  };

  home.sessionVariables = { EDITOR = "nvim"; };
}

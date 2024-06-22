{ pkgs, ... }:

{
  home.packages = with pkgs; [ gcc nixd nixfmt-rfc-style ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
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

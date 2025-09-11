{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    ripgrep
    lua-language-server
    nixd
    nixfmt-rfc-style
  ];

  programs.neovim = {
    enable = true;
    # Uncomment this to use a later version than the current NixOS version will allow.
    # package = pkgs.unstable.neovim-unwrapped;
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

    "./nvim/init.lua" = {
      source = ./nvim/init.lua;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

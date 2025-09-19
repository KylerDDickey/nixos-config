{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # General nvim dependencies
    gcc
    ripgrep

    # Default LSP and formatters for Lua and Nix development
    lua-language-server
    stylua
    nixd
    nixfmt-rfc-style

    # Ensure Mason dependencies are installed.
    # git -- Usually ignore, should already be installed
    curl
    unzip
    gnutar
    gzip
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
    "./nvim" = pkgs.neovim-config;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

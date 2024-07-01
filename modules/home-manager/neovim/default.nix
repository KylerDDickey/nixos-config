{ pkgs, ... }:
let
  treesitterWithGrammars = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.bash
      p.comment
      p.css
      p.gitattributes
      p.gitignore
      p.go
      p.gomod
      p.gowork
      p.javascript
      p.jq
      p.json
      p.json5
      p.lua
      p.make
      p.markdown
      p.nix
      p.rust
      p.toml
      p.tsx
      p.typescript
      p.yaml
    ])
  );

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
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
    package = pkgs.unstable.neovim-unwrapped;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;

    plugins = [ treesitterWithGrammars ];
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
      text = ''
        ${(builtins.readFile ./nvim/init.lua)}
        vim.opt.runtimepath:append("${treesitter-parsers}")
      '';
    };
  };

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

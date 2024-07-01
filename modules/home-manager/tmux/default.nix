{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
  };

  xdg.configFile = {
    "./tmux/tmux.conf" = {
      source = ./tmux.conf;
    };
  };

  home.file.".tmux/plugins/tpm" = {
    source = builtins.fetchGit {
      url = "https://github.com/tmux-plugins/tpm";
      ref = "refs/tags/v3.1.0";
      rev = "c628645dfa7c4fc16acfb7a73c9d7a98697b472c";
    };
  };
}

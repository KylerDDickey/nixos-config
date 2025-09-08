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

  home.packages = with pkgs; [
    (writeShellApplication {
      name = "ide";
      runtimeInputs = [ tmux ];
      text = ''
        NUM_COLS=$(tput cols)
        NUM_LINES=$(tput lines)
        CMD_WINDOW_PERCENT_SIZE=20%

        # Start a new detached tmux session named 'dev', ensure window is sized the same
        # as the current terminal.
        tmux new-session -s "dev" -d -x "$NUM_COLS" -y "$NUM_LINES"

        # Split the window vertically, make sure the new pane is only N% of the window.
        tmux split-window -t dev -v -l "$CMD_WINDOW_PERCENT_SIZE"

        # Move cursor back to the nvim terminal.
        tmux last-pane -t dev

        # Send the nvim command to the first pane of the 'dev' session.
        tmux send-keys -t dev "nvim" C-m

        # Attach to the tmux session.
        tmux attach-session -t dev
      '';
    })
  ];
}

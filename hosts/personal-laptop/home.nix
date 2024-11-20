{ outputs, pkgs, ... }:
{
  home.username = "kyler";
  home.homeDirectory = "/home/kyler";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];
  };

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "JetBrainsMono"
      ];
    })
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kyler/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { };

  imports = [
    ../../modules/home-manager/alacritty
    ../../modules/home-manager/bash
    ../../modules/home-manager/neovim
    ../../modules/home-manager/shadow
    ../../modules/home-manager/tmux
    ../../modules/home-manager/zsh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

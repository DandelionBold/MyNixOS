{ config, pkgs, ... }:

{
  # Home Manager base for user casper (standalone usage)
  home.username = "casper";
  home.homeDirectory = "/home/casper";

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Aliases and prompt tweaks can be added here
      alias ll='ls -lah'
    '';
  };

  programs.git = {
    enable = true;
    userName = "casper";
    userEmail = ""; # fill later
  };

  # Home state version for compatibility
  home.stateVersion = "24.05";
}



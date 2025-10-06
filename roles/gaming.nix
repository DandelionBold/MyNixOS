{ config, lib, pkgs, ... }:

{
  # Opt-in gaming stack (disabled by default)
  programs.steam.enable = lib.mkDefault false;
  # Proton GE and Gamescope can be added later as options
}



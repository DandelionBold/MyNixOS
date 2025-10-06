{ config, lib, pkgs, ... }:

{
  # Gaming stack (disabled by default)
  programs.steam.enable = lib.mkDefault false;
}



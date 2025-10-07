{ config, lib, pkgs, ... }:

{
  # Media tools and players
  environment.systemPackages = with pkgs; [
    vlc
  ];
}

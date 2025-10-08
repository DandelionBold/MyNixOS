{ config, lib, pkgs, ... }:

{
  # Browser applications
  
  # Firefox - Default browser
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  # Additional browsers
  environment.systemPackages = with pkgs; [
    brave
    google-chrome
    chromium
  ];

  # Allow unfree for exactly what we use
  my.allowedUnfreePackages = [ "brave" "google-chrome" ];
}

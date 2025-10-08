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

  # Allow unfree browsers for this feature
  my.allowedUnfreePackages = [ "brave" "google-chrome" ];
}

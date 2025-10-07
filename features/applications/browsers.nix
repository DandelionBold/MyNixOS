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
    brave        # Privacy-focused browser
    # chromium   # Open-source Chrome (uncomment if needed)
    # google-chrome # Google Chrome (uncomment if needed)
  ];
}

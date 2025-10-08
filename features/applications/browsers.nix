{ config, lib, pkgs, ... }:

{
  # Browser applications
  
  # Firefox - Default browser
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  # Additional browsers (avoid unfree by default)
  # Uncomment brave or chrome on hosts that explicitly allow unfree
  environment.systemPackages = with pkgs; [
    # brave        # Privacy-focused browser (unfree)
    chromium       # Open-source Chrome
    # google-chrome # Google Chrome (unfree)
  ];
}

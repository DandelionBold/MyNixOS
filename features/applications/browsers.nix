{ config, lib, pkgs, ... }:

{
  # Browser applications
  
  # Firefox - Default browser
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  # Additional browsers
  let
    bravePkg = pkgs.brave;
    chromePkg = pkgs.google-chrome;
    unfreePkgs = [ bravePkg chromePkg ];
    unfreeNames = map (p: lib.getName p) unfreePkgs;
  in
  {
    environment.systemPackages = [
      bravePkg
      chromePkg
      pkgs.chromium
    ];

    # Allow unfree for exactly what we use
    my.allowedUnfreePackages = unfreeNames;
  }
}

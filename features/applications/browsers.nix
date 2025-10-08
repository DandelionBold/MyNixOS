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
  in
  {
    environment.systemPackages = [
      bravePkg
      chromePkg
      pkgs.chromium
    ];

    # Allow unfree for exactly what we use
    my.allowedUnfreePackages = [ (lib.getName bravePkg) (lib.getName chromePkg) ];
  }
}

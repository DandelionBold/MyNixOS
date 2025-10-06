{ config, pkgs, lib, ... }:

{
  # Desktop host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Desktop-specific modules
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    # ../modules/filesystems-btrfs.nix

    # Desktop-specific features
    ../features/desktop-environments/desktop-environment.nix
    ../features/applications/browsers.nix
    ../features/applications/system-tools.nix
    ../features/applications/other-applications.nix
    ../modules/fonts.nix
    ../modules/power.nix
  ];

  networking.hostName = "desktop";
  networking.firewall.enable = false;
}



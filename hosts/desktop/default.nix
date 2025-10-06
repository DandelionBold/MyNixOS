{ config, pkgs, lib, ... }:

{
  # Desktop host type
  imports = [
    # Base modules (common to all hosts)
    ../modules/base.nix
    
    # Desktop-specific modules
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    # ../modules/filesystems-btrfs.nix

    # Desktop-specific features
    ../features/desktop.nix
  ];

  networking.hostName = "desktop";
  networking.firewall.enable = false;
}



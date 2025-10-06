{ config, pkgs, lib, ... }:

{
  # Laptop host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Laptop-specific modules
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    # ../modules/filesystems-btrfs.nix  # enable after disk layout is finalized

    # Laptop-specific features
    ../features/desktop-environments/desktop-environment.nix
    ../features/applications/browsers.nix
    ../features/applications/terminals.nix
    ../features/applications/file-managers.nix
    ../features/applications/gui-text-editors.nix
    ../features/applications/screenshot-tools.nix
    ../features/applications/media-tools.nix
    ../features/applications/office-suite.nix
    ../features/applications/system-tools.nix
    ../features/applications/other-applications.nix
    ../modules/hibernate.nix
    ../features/development/dev.nix
    ../modules/power.nix

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  networking.firewall.enable = false;
}



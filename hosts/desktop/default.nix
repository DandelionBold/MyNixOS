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
    ../modules/fonts.nix
    ../modules/power.nix
  ];

  # Desktop environment: KDE Plasma 6 + SDDM on Wayland
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Applications
  programs.firefox.enable = true;

  networking.hostName = "desktop";
  networking.firewall.enable = false;
}



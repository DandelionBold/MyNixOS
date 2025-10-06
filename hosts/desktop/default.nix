{ config, pkgs, lib, ... }:

{
  # Desktop host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Desktop-specific features
    ../features/bluetooth.nix
    ../features/printing.nix
    ../features/audio.nix
    ../features/fonts.nix
    ../features/power.nix
    # ../features/filesystems-btrfs.nix
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



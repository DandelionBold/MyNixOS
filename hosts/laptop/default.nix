{ config, pkgs, lib, ... }:

{
  # Laptop host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Laptop-specific features
    ../features/bluetooth.nix
    ../features/printing.nix
    ../features/audio.nix
    ../features/hibernate.nix
    ../features/dev.nix
    ../features/power.nix
    # ../features/filesystems-btrfs.nix  # enable after disk layout is finalized

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  # Desktop environment: KDE Plasma 6 + SDDM on Wayland
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Applications
  programs.firefox.enable = true;

  networking.hostName = "laptop";
  networking.firewall.enable = false;
}



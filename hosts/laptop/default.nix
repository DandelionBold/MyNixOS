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

    # Laptop-specific features (workstation + hibernate + power + dev)
    ../features/workstation.nix
    ../modules/hibernate.nix
    ../features/dev.nix
    ../modules/power.nix

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  networking.firewall.enable = false;
}



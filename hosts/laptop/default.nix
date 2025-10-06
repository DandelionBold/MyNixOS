{ config, pkgs, lib, ... }:

{
  # Laptop host type
  imports = [
    # Base modules (common to all hosts)
    ../modules/base.nix
    
    # Laptop-specific modules
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    # ../modules/filesystems-btrfs.nix  # enable after disk layout is finalized

    # Laptop-specific roles
    ../roles/laptop.nix
    ../roles/dev.nix

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  networking.firewall.enable = false;
}



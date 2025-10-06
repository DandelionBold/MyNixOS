{ config, pkgs, lib, ... }:

{
  # Laptop host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    ../modules/users-casper.nix
    # ../modules/filesystems-btrfs.nix  # enable after disk layout is finalized

    ../roles/laptop.nix
    ../roles/dev.nix

    # Per-user overlay for this laptop (personal)
    ./personal/casper.nix
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  networking.firewall.enable = false;
}



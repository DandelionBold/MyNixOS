{ config, pkgs, lib, ... }:

{
  # Laptop host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    ../modules/user.nix
    # ../modules/filesystems-btrfs.nix  # enable after disk layout is finalized

    ../roles/laptop.nix
    ../roles/dev.nix

    # Per-user overlay for this laptop (personal)
    ./personal/personal.nix
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  networking.firewall.enable = false;
}



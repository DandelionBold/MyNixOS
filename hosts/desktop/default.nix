{ config, pkgs, lib, ... }:

{
  # Desktop host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    ../modules/users-casper.nix
    # ../modules/filesystems-btrfs.nix

    ../roles/desktop.nix
  ];

  networking.hostName = "desktop";
  networking.firewall.enable = false;
}



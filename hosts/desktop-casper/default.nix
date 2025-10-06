{ config, pkgs, lib, ... }:

{
  # Desktop host example (no laptop-specific power tweaks)
  imports = [
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/bluetooth.nix
    ../../modules/printing.nix
    ../../modules/audio.nix
    ../../modules/users-casper.nix
    # ../../modules/filesystems-btrfs.nix  # enable after disk layout is finalized

    ../../roles/desktop.nix
  ];

  networking.hostName = "desktop-casper";

  # Global policy set in flake; keep here if we later split configs
  nixpkgs.config.allowUnfree = true;

  # Firewall off globally; enable per-host if needed
  networking.firewall.enable = false;
}



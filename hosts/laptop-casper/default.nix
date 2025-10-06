{ config, pkgs, lib, ... }:

{
  # Entry module for host laptop-casper.
  # Import shared modules and roles to avoid duplication.

  imports = [
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/bluetooth.nix
    ../../modules/printing.nix
    ../../modules/audio.nix
    ../../modules/users-casper.nix
    # ../../modules/filesystems-btrfs.nix  # enable after disk layout is finalized

    ../../roles/workstation.nix
    ../../roles/dev.nix
    # ../../roles/gaming.nix   # opt-in, leave disabled by default

    # Profile toggles for laptops (hibernate, power tweaks)
    ../../profiles/laptop.nix
  ];

  networking.hostName = "laptop-casper";

  # Global policy set in flake; keep here if we later split configs
  nixpkgs.config.allowUnfree = true;

  # Firewall off globally as per roadmap; per-host allowed ports will be templated later
  networking.firewall.enable = false;
}



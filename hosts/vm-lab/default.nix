{ config, pkgs, lib, ... }:

{
  # Minimal VM host (headless by default)
  imports = [
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../roles/server.nix
  ];

  networking.hostName = "vm-lab";
  networking.firewall.enable = false;
}



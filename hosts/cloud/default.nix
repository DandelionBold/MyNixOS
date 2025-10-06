{ config, pkgs, lib, ... }:

{
  # Cloud host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../roles/server.nix
  ];

  networking.hostName = "cloud";
  networking.firewall.enable = false;
}



{ config, pkgs, lib, ... }:

{
  # VM host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../profiles/vm.nix
  ];

  networking.hostName = "vm";
  networking.firewall.enable = false;
}



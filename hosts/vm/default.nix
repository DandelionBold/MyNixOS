{ config, pkgs, lib, ... }:

{
  # VM host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/user.nix
    ../modules/vm.nix
    ../profiles/vm.nix

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "vm";
  networking.firewall.enable = false;
}



{ config, pkgs, lib, ... }:

{
  # VM host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../profiles/vm.nix

    # Per-user overlay for this VM (personal)
    ./personal/casper.nix
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "vm";
  networking.firewall.enable = false;
}



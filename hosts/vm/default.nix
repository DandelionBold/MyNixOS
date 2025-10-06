{ config, pkgs, lib, ... }:

{
  # VM host type
  imports = [
    # Base modules (common to all hosts)
    ../modules/base.nix
    
    # VM-specific modules
    ../modules/vm.nix
    ../profiles/vm.nix

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "vm";
  networking.firewall.enable = false;
}



{ config, pkgs, lib, ... }:

{
  # Cloud host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Cloud-specific features
    ../features/server.nix
  ];

  networking.hostName = "cloud";
  networking.firewall.enable = false;
}



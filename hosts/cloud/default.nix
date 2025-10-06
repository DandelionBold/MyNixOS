{ config, pkgs, lib, ... }:

{
  # Cloud host type
  imports = [
    # Base modules (common to all hosts)
    ../modules/base.nix
    
    # Cloud-specific features
    ../features/server.nix
  ];

  networking.hostName = "cloud";
  networking.firewall.enable = false;
}



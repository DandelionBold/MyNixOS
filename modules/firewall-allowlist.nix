{ config, lib, pkgs, ... }:

{
  # Firewall is globally disabled per roadmap. This module allows per-host allow-lists
  # if the host chooses to enable the firewall.
  # Example in a host:
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 22 80 443 ];
  #   allowedUDPPorts = [ ];
  # };
}



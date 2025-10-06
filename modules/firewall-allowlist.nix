{ config, lib, pkgs, ... }:

{
  # Firewall is globally disabled per roadmap. This module allows per-host allow-lists
  # if the host chooses to enable the firewall.
  
  # Options for per-host firewall configuration
  options.networking.firewall.allowedTCPPorts = lib.mkOption {
    type = lib.types.listOf lib.types.port;
    default = [ ];
    description = "List of TCP ports to allow through the firewall";
  };
  
  options.networking.firewall.allowedUDPPorts = lib.mkOption {
    type = lib.types.listOf lib.types.port;
    default = [ ];
    description = "List of UDP ports to allow through the firewall";
  };

  # Example in a host:
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 22 80 443 ];
  #   allowedUDPPorts = [ ];
  # };
}



{ config, pkgs, lib, ... }:

{
  # Import the base laptop configuration
  imports = [ 
    ../default.nix
    # Hardware configuration (auto-generated, specific to this machine)
    ./hardware-configuration.nix
  ];
  
  # Add any personal laptop-specific customizations here
  # Example: services.nginx.enable = true;
  # Example: services.mysql.enable = true;
}



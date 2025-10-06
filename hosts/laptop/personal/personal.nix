{ config, pkgs, lib, ... }:

{
  # Import the base laptop configuration
  imports = [ ../default.nix ];
  
  # Personal overrides for laptop
  _module.args.user = "casper";
  
  # Add any personal laptop-specific customizations here
  # Example: services.nginx.enable = true;
  # Example: services.mysql.enable = true;
}



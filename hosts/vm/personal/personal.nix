{ config, pkgs, lib, ... }:

{
  # Import the base VM configuration
  imports = [ 
    ../default.nix
    # Hardware configuration (auto-generated, specific to this VM)
    ./hardware-configuration.nix
  ];
  
  # Personal overrides for VM
  _module.args.vmType = "virtualbox";
  
  # Add any personal VM-specific customizations here
  # Example: services.nginx.enable = true;
  # Example: services.mysql.enable = true;
}

{ config, lib, pkgs, ... }:

{
  # System monitoring and utilities
  environment.systemPackages = with pkgs; [
    # System monitoring
    htop
    
    # Archive tools
    unzip
  ];
}

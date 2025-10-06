{ config, lib, pkgs, ... }:

{
  # System monitoring and utilities
  environment.systemPackages = with pkgs; [
    # System monitoring
    neofetch
    btop
    lshw
    htop
    tree
    
    # Archive tools
    ark
    file-roller
    p7zip
    unzip
    zip
  ];
}

{ config, lib, pkgs, ... }:

{
  # Other applications that don't fit specific categories
  environment.systemPackages = with pkgs; [
    # System utilities
    htop
    tree
    wget
    curl
    unzip
    zip
    
    # Media tools
    vlc
    gimp
    
    # Office suite
    libreoffice
    
    # Add more general applications here as needed
  ];
}

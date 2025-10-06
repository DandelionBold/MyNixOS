{ config, lib, pkgs, ... }:

{
  # System tools and utilities
  environment.systemPackages = with pkgs; [
    # Terminals
    alacritty
    kitty
    gnome.gnome-terminal
    
    # File managers
    dolphin
    thunar
    ranger
    
    # GUI text editors
    kate
    gedit
    mousepad
    
    # Screenshot tools
    spectacle
    flameshot
    scrot
    
    # System monitoring
    neofetch
    btop
    lshw
    
    # Network tools
    nmap
    wireshark
    netcat
    
    # Archive tools
    ark
    file-roller
    p7zip
  ];
}

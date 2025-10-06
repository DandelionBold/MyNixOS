{ config, lib, pkgs, ... }:

{
  # Desktop environment: KDE Plasma 6 + SDDM on Wayland
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Applications
  programs.firefox.enable = true;
}



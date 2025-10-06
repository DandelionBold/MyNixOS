{ config, lib, pkgs, ... }:

{
  # KDE Plasma 6 desktop environment
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}

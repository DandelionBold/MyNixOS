{ config, lib, pkgs, ... }:

{
  # Background images configuration
  # Local background images (not from internet)
  
  # Copy background images to system
  environment.etc = {
    "backgrounds" = {
      source = ./backgrounds;
      target = "backgrounds";
    };
  };

  # KDE Plasma wallpaper configuration
  services.desktopManager.plasma6 = lib.mkIf config.services.desktopManager.plasma6.enable {
    enable = true;
    # Set default wallpaper
    wallpaper = "/etc/backgrounds/default.jpg";
  };

  # SDDM background configuration
  services.displayManager.sddm = lib.mkIf config.services.displayManager.sddm.enable {
    enable = true;
    settings = {
      Theme = {
        Current = "breeze";
        # Custom background
        Background = "/etc/backgrounds/sddm.jpg";
      };
    };
  };

  # GNOME wallpaper (if using GNOME)
  services.xserver.desktopManager.gnome = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
    enable = true;
    # Set wallpaper
    wallpaper = "/etc/backgrounds/gnome.jpg";
  };
}

{ config, lib, pkgs, ... }:

{
  # Light theme configuration
  # Based on nixy light themes
  
  # GTK Light Theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
  };

  # Qt Light Theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  # Light color scheme
  colorScheme = {
    name = "Adwaita";
    colors = {
      # Light color palette
      base00 = "f8f8f2"; # Background
      base01 = "f8f8f2"; # Lighter background
      base02 = "f4f4f4"; # Selection background
      base03 = "9ca0a4"; # Comments
      base04 = "2e3440"; # Dark foreground
      base05 = "2e3440"; # Default foreground
      base06 = "2e3440"; # Light foreground
      base07 = "2e3440"; # Lightest foreground
      base08 = "bf616a"; # Red
      base09 = "d08770"; # Orange
      base0A = "ebcb8b"; # Yellow
      base0B = "a3be8c"; # Green
      base0C = "88c0d0"; # Cyan
      base0D = "81a1c1"; # Blue
      base0E = "b48ead"; # Magenta
      base0F = "5e81ac"; # Brown
    };
  };

  # KDE Plasma light theme
  services.desktopManager.plasma6 = lib.mkIf config.services.desktopManager.plasma6.enable {
    enable = true;
    theme = "breeze";
    lookAndFeel = "org.kde.breeze.desktop";
  };
}

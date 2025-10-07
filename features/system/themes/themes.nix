{ config, lib, pkgs, ... }:

{
  # Theme configuration system
  # Based on nixy themes: https://github.com/anotherhadi/nixy/tree/main/themes
  
  # GTK Theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    # Note: cursorTheme is not a standard NixOS GTK option
    # Cursor themes are typically set via desktop environment or user configuration
  };

  # Qt Theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # System fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      
      # Icon fonts
      material-design-icons
      font-awesome
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Liberation Serif" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" ];
        monospace = [ "Fira Code" "Liberation Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # KDE Plasma theme (if using KDE)
  # Note: This doesn't enable Plasma, just configures its theme
  services.desktopManager.plasma6 = lib.mkIf config.services.desktopManager.plasma6.enable {
    # Plasma theme configuration
    theme = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";
  };

  # SDDM theme (if using SDDM)
  # Note: This doesn't enable SDDM, just configures its theme
  services.displayManager.sddm = lib.mkIf config.services.displayManager.sddm.enable {
    theme = "breeze";
    settings = {
      Theme = {
        Current = "breeze";
      };
    };
  };
}

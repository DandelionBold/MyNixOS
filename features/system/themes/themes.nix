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
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
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
  services.desktopManager.plasma6 = lib.mkIf config.services.desktopManager.plasma6.enable {
    enable = true;
    # Plasma theme configuration
    theme = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";
  };

  # SDDM theme
  services.displayManager.sddm = lib.mkIf config.services.displayManager.sddm.enable {
    enable = true;
    theme = "breeze";
    settings = {
      Theme = {
        Current = "breeze";
      };
    };
  };
}

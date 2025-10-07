{ lib, pkgs, config, ... }:
let
  cfg = config.theme;
in
{
  options.theme = {
    enable = lib.mkEnableOption "User theme (GTK, icons, cursor)";
    gtkThemePackage = lib.mkOption { type = lib.types.package; default = pkgs.adw-gtk3; };
    gtkThemeName    = lib.mkOption { type = lib.types.str;     default = "adw-gtk3-dark"; };

    iconPackage     = lib.mkOption { type = lib.types.package; default = pkgs.papirus-icon-theme; };
    iconName        = lib.mkOption { type = lib.types.str;     default = "Papirus-Dark"; };

    cursorPackage   = lib.mkOption { type = lib.types.package; default = pkgs.bibata-cursor-theme; };
    cursorName      = lib.mkOption { type = lib.types.str;     default = "Bibata-Modern-Ice"; };
    cursorSize      = lib.mkOption { type = lib.types.int;     default = 24; };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.gtkThemePackage cfg.iconPackage cfg.cursorPackage ];

    gtk = {
      enable = true;
      theme      = { package = cfg.gtkThemePackage; name = cfg.gtkThemeName; };
      iconTheme  = { package = cfg.iconPackage;     name = cfg.iconName; };
      cursorTheme = {
        package = cfg.cursorPackage;
        name    = cfg.cursorName;
        size    = cfg.cursorSize;
      };
    };

    home.sessionVariables = {
      GTK_THEME     = cfg.gtkThemeName;
      XCURSOR_THEME = cfg.cursorName;
      XCURSOR_SIZE  = toString cfg.cursorSize;
    };
  };
}

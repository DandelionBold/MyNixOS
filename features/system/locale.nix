{ config, lib, pkgs, ... }:

{
  # Locale, timezone and keyboard defaults
  time.timeZone = "Africa/Cairo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ar_EG.UTF-8/UTF-8" ];

  services.xserver.xkb = {
    layout = "us,ara";
    variant = "";
    options = "grp;alt_shift_toggle";
  };
}



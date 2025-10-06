{ config, lib, pkgs, ... }:

{
  # Dark theme configuration - imports base theme and adds dark colors
  imports = [ ./themes.nix ];

  # Dark color scheme
  colorScheme = {
    name = "Adwaita-dark";
    colors = {
      # Dark color palette
      base00 = "2e3440"; # Background
      base01 = "3b4252"; # Lighter background
      base02 = "434c5e"; # Selection background
      base03 = "4c566a"; # Comments
      base04 = "d8dee9"; # Dark foreground
      base05 = "e5e9f0"; # Default foreground
      base06 = "eceff4"; # Light foreground
      base07 = "8fbcbb"; # Lightest foreground
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

  # Override GTK theme to dark
  gtk.theme.name = "Adwaita-dark";
  qt.style = "adwaita-dark";
}

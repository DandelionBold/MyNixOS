{ config, lib, pkgs, ... }:

{
  # Dark theme configuration - imports base theme and adds dark colors
  imports = [ ./themes.nix ];

  # Dark color scheme (removed invalid colorScheme option)
  # Note: Color schemes are typically handled by individual applications

  # Override GTK theme to dark
  gtk.theme.name = "Adwaita-dark";
  qt.style = "adwaita-dark";
}

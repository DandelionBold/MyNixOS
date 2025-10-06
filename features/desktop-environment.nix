{ config, lib, pkgs, ... }:

{
  # Desktop environment feature - imports KDE Plasma
  imports = [
    ../features/kde-plasma.nix
  ];
}

{ config, lib, pkgs, ... }:

{
  # Desktop environment feature - imports KDE Plasma
  imports = [
    ./kde-plasma.nix
  ];
}

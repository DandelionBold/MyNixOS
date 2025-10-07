{ config, lib, pkgs, ... }:

{
  # Office suite applications
  environment.systemPackages = with pkgs; [
    libreoffice
  ];
}

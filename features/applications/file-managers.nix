{ config, lib, pkgs, ... }:

{
  # File manager applications
  # Dolphin moved to Qt6; use kdePackages.dolphin
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
  ];
}

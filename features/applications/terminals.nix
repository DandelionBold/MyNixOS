{ config, lib, pkgs, ... }:

{
  # Terminal applications
  # Konsole moved to Qt6; use kdePackages.konsole
  environment.systemPackages = with pkgs; [
    kdePackages.konsole
  ];
}

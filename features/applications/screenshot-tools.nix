{ config, lib, pkgs, ... }:

{
  # Screenshot and screen recording tools
  # Spectacle moved to Qt6; use kdePackages.spectacle
  environment.systemPackages = with pkgs; [
    kdePackages.spectacle
  ];
}

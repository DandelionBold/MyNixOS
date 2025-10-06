{ config, lib, pkgs, ... }:

{
  # Screenshot and screen recording tools
  environment.systemPackages = with pkgs; [
    spectacle
    flameshot
    scrot
    obs-studio
    simplescreenrecorder
  ];
}

{ config, lib, pkgs, ... }:

{
  # Screenshot and screen recording tools
  environment.systemPackages = with pkgs; [
    spectacle
  ];
}

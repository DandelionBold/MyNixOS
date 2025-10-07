{ config, lib, pkgs, ... }:

{
  # File manager applications
  environment.systemPackages = with pkgs; [
    dolphin
  ];
}

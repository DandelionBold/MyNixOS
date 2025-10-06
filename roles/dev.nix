{ config, lib, pkgs, ... }:

{
  # Docker development environment
  virtualisation.docker.enable = true;
  
  # Python toolchain (initial)
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.wheel
  ];
}



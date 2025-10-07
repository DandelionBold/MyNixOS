{ config, lib, pkgs, ... }:

{
  # Terminal applications
  environment.systemPackages = with pkgs; [
    konsole
  ];
}

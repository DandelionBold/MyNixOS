{ config, lib, pkgs, ... }:

{
  # Desktop role: workstation + fonts + power management
  imports = [
    ../roles/workstation.nix
    ../modules/fonts.nix
    ../modules/power.nix
  ];
}

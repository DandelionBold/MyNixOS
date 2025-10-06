{ config, lib, pkgs, ... }:

{
  # Desktop role: workstation + fonts + power management
  imports = [
    ../features/workstation.nix
    ../modules/fonts.nix
    ../modules/power.nix
  ];
}

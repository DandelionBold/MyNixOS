{ config, lib, pkgs, ... }:

{
  # Laptop role: desktop + hibernate + power tweaks
  imports = [
    ../features/desktop.nix
    ../modules/hibernate.nix
  ];

  # Power management for laptops
  powerManagement.powertop.enable = true;
}

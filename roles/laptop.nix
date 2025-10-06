{ config, lib, pkgs, ... }:

{
  # Laptop role: desktop + hibernate + power tweaks
  imports = [
    ../roles/desktop.nix
    ../modules/hibernate.nix
  ];

  # Enable powertop for laptops
  powerManagement.powertop.enable = true;
}

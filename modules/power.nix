{ config, lib, pkgs, ... }:

{
  # Power management defaults
  powerManagement = {
    enable = true;
    powertop.enable = lib.mkDefault false;
  };

  services.power-profiles-daemon.enable = true;
}

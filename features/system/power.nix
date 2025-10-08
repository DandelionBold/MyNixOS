{ config, lib, pkgs, ... }:

{
  # Power management defaults (can be overridden by hosts)
  powerManagement = {
    enable = lib.mkDefault true;
    powertop.enable = lib.mkDefault false;
  };

  services.power-profiles-daemon.enable = lib.mkDefault true;
}

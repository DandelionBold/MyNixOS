{ config, lib, pkgs, ... }:

{
  # Power management defaults
  powerManagement = {
    enable = true;
    powertop.enable = lib.mkDefault false; # enable per profile if needed
  };

  services.power-profiles-daemon.enable = true;
}

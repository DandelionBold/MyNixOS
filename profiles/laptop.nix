{ config, lib, pkgs, ... }:

{
  # Laptop profile: power tweaks and hibernation toggle
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = true;

  # Hibernate support (requires swap and resume configured per host)
  systemd.targets.hibernate.enable = lib.mkDefault true;
}



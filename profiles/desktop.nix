{ config, lib, pkgs, ... }:

{
  # Desktop profile: no laptop-specific power tweaks by default
  services.power-profiles-daemon.enable = true;
}



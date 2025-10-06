{ config, lib, pkgs, ... }:

{
  services.printing.enable = true;
  hardware.sane.enable = true;
}



{ config, lib, pkgs, ... }:

{
  # GUI text editors
  # Kate moved to Qt6; use kdePackages.kate
  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];
}

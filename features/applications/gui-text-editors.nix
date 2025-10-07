{ config, lib, pkgs, ... }:

{
  # GUI text editors
  environment.systemPackages = with pkgs; [
    kate
  ];
}

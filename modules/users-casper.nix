{ config, lib, pkgs, ... }:

{
  users.users.casper = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.bashInteractive;
  };
}



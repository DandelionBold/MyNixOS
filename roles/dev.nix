{ config, lib, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.users.casper.extraGroups = lib.mkIf (config.users.users.casper or null != null) (config.users.users.casper.extraGroups or []) ++ [ "docker" ];
  # Add language toolchains as needed via pkgs (Python initially)
}



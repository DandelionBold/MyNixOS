{ config, lib, pkgs, ... }:

{
  # Docker development environment
  virtualisation.docker.enable = true;
  
  # Add casper to docker group if user exists
  users.users.casper.extraGroups = lib.mkIf (config.users.users.casper or null != null) 
    (config.users.users.casper.extraGroups or []) ++ [ "docker" ];
}



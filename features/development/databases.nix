{ config, lib, pkgs, ... }:

{
  # Database services - all disabled by default
  
  # MySQL (MariaDB)
  services.mysql = {
    enable = lib.mkDefault false;
    package = pkgs.mariadb;
  };

  # Microsoft SQL Server (not available in standard NixOS)
  # Note: MSSQL Server is not available as a standard NixOS service
  # Consider using Docker or alternative solutions

  # Redis
  services.redis.enable = lib.mkDefault false;
}



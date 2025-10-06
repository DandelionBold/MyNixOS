{ config, lib, pkgs, ... }:

{
  # Database services - all disabled by default
  
  # MySQL (MariaDB)
  services.mysql = {
    enable = lib.mkDefault false;
    package = pkgs.mariadb;
  };

  # Microsoft SQL Server
  services.mssql.enable = lib.mkDefault false;

  # Redis
  services.redis.enable = lib.mkDefault false;
}


